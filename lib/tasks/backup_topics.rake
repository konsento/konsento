namespace :utils do
  namespace :backup do
    desc "Backup topics"

    task :topics => :environment do
      topics = Topic.all
      all_topics = ""

      topics.each do |topic|
        all_topics += topic.to_json + "\n"
      end

      File.open("topics.txt", "w") do |f|
        f.write all_topics
      end
    end
  end
end
