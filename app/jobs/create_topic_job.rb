class CreateTopicJob < ActiveJob::Base
  queue_as :create_topic

  def perform(params)
    location = Location.find(params[:location_id])

    topic = location.topics.create!(
      params.except(:proposals_attributes, :auto_split_text)
    ) do |t|
      i = 0
      params[:proposals_attributes].each do |(k, p)|
        if params[:auto_split_text] == 'on' && p[:content].each_line.count > 100
          contents = p[:content].each_line.map { |c| c.squish.presence }.compact
          contents.each do |c|
            s = t.sections.build(index: i)
            s.proposals.build(user_id: params[:user_id], content: c)
            i += 1
          end
        else
          s = t.sections.build(index: i)
          s.proposals.build(user_id: params[:user_id], content: p[:content])
          i += 1
        end
      end
    end

    Notification.create!(
      user: topic.user,
      key: 'topic_processed',
      data: {},
      notifiable: topic
    )
  rescue => e
    logger.error [e.message, e.backtrace.inspect].inspect

    Notification.create!(
      user_id: params[:user_id],
      key: 'topic_processing_error',
      data: {}
    )
  end

  private

  def logger
    @logger ||= Logger.new(File.join(Rails.root, 'log', 'create_topic_job.log'))
  end
end
