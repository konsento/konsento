namespace :utils do
  namespace :backup do
    desc "Backup votes"

    task :votes => :environment do
      votes = Vote.all
      all_votes = ""

      votes.each do |vote|
        all_votes += vote.to_json + "\n"
      end

      File.open("votes.txt", "w") do |f|
        f.write all_votes
      end
    end
  end
end
