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
    @proposal.vote_agree(current_user)
  end

  def abstain
    @proposal.vote_abstain(current_user)
  end

  def disagree
    @proposal.vote_disagree(current_user)
  end

  def propose
    @new_proposal = @proposal.dup
    @new_proposal.user = current_user
    @new_proposal.parent = @proposal
    @new_proposal.references.build
  end

  def new
    topic = Topic.find(params[:topic_id])
    section = topic.sections.build
    @proposal = section.proposals.build
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
end
