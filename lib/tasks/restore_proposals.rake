namespace :utils do
  namespace :restore do
    desc "Restore backed up proposals"

    task :proposals => :environment do
      File.open("proposals.txt", "r") do |file|
        file.each_line do |l|
          proposal = Proposal.new(JSON.parse(l))
          proposal.save!(validate: false)
        end
      end
    end
  end
end
