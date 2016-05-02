namespace :utils do
  namespace :restore do
    desc "Restore backed up topics"

    task :topics => :environment do
      File.open("topics.txt", "r") do |file|
        file.each_line do |l|
          topic = Topic.new(JSON.parse(l))
          topic.save!(validate: false)
        end
      end
    end
  end
end
