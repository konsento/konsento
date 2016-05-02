namespace :utils do
  namespace :restore do
    desc "Restore backed up votes"

    task :votes => :environment do
      File.open("votes.txt", "r") do |file|
        file.each_line do |l|
          vote = Vote.new(JSON.parse(l))
          vote.save!(validate: false)
        end
      end
    end
  end
end
