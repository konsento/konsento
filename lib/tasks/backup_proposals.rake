namespace :utils do
  namespace :backup do
    desc "Backup proposals"

    task :proposals => :environment do
      proposals = User.all
      all_proposals = ""

      proposals.each do |proposal|
        all_proposals += proposal.to_json + "\n"
      end

      File.open("proposals.txt", "w") do |f|
        f.write all_proposals
      end
    end
  end
end
