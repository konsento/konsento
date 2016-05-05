class Js::ProposalsController < ApplicationController
  respond_to :js

  before_action :set_proposal, except: [:index, :new, :create]

  def index
    topic = Topic.find(params[:topic_id])
    section = topic.sections.find(params[:section_id])

    @is_user_subscribed = topic.location.is_user_subscribed?(current_user)

    proposals = section.proposals.where.not(id: section.consensus.try(:id))
    @recent = proposals.recent.page(params[:recent_page])
    @popular = proposals.popular.page(params[:popular_page])
    @controversial = proposals.controversial.page(params[:controversial_page])
  end

  def comments
    @comment = Comment.new(commentable: @proposal, user: current_user)
    @is_user_subscribed = @proposal.topic.location.is_user_subscribed?(current_user)
  end

  def agree
    @result = user_is_able_to_perform_action
    if @result == "just_subscribed" || @result == "able"
      @proposal.vote_agree(current_user)
    end
  end

  def abstain
    @result = user_is_able_to_perform_action
    if @result == "just_subscribed" || @result == "able"
      @proposal.vote_abstain(current_user)
    end
  end

  def disagree
    @result = user_is_able_to_perform_action
    if @result == "just_subscribed" || @result == "able"
      @proposal.vote_disagree(current_user)
    end
  end

  def propose
    @result = user_is_able_to_perform_action
    if @result == "just_subscribed" || @result == "able"
      @new_proposal = @proposal.dup
      @new_proposal.user = current_user
      @new_proposal.parent = @proposal
      @new_proposal.references.build
    end
  end

  def new
    @result = user_is_able_to_perform_action
    if @result == "just_subscribed" || @result == "able"
      topic = Topic.find(params[:topic_id])
      section = topic.sections.build
      @proposal = section.proposals.build
    end
  end

  def create
    topic = Topic.find(params[:topic_id])

    topic.transaction do
      if params[:next_section]
        sections = topic.sections.where('index >= ?', params[:next_section]).map do |s|
          i = s.index + 1
          s.index = nil
          s.save!(validate: false)
          [s, i]
        end

        sections.each { |s, i| s.update!(index: i) }

        index = params[:next_section]
      else
        index = topic.sections.last.index + 1
      end

      section = topic.sections.build(index: index) do |s|
        s.proposals.build(
          content: params[:proposal][:content].squish,
          user: current_user
        )
      end

      section.save!
    end

    redirect_to topic
  end

  private
    def set_proposal
      @proposal = Proposal.find(params[:id])
    end

    def user_is_able_to_perform_action
      if signed_in?
        unless @proposal.blank?
          if @proposal.topic.location.is_user_subscribed?(current_user)
            return "able"
          else
            @subscription = @proposal.topic.location.subscriptions.find_or_initialize_by(user: current_user)
            @subscription.role = 'default'

            if @subscription.save
              return "just_subscribed"
            else
              @redirect_url = url_for(
                controller: '/requirement_values',
                action: 'new',
                requirable_id: @subscription.subscriptable.id,
                requirable_type: @subscription.subscriptable_type,
                user_id: @subscription.user.id
              )
              return "not_able_to_subscribe"
            end
          end
        else
          topic = Topic.find(params[:topic_id])
          unless topic.blank?
            if topic.location.is_user_subscribed?(current_user)
              return "able"
            else
              @subscription = topic.location.subscriptions.find_or_initialize_by(user: current_user)
              @subscription.role = 'default'

              if @subscription.save
                return "just_subscribed"
              else
                @redirect_url = url_for(
                  controller: '/requirement_values',
                  action: 'new',
                  requirable_id: @subscription.subscriptable.id,
                  requirable_type: @subscription.subscriptable_type,
                  user_id: @subscription.user.id
                )
                return "not_able_to_subscribe"
              end
            end
          end
        end
      else
        @redirect_url = sign_in_path
        return "not_logged"
      end
    end
end
