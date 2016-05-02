namespace :utils do
  namespace :restore do
    desc "Restore backed up teams"

    task :teams => :environment do
      File.open("teams.txt", "r") do |file|
        file.each_line do |l|
          team = Team.new(JSON.parse(l))
          team.save!(validate: false)
        end
      end
    end
  end
end
