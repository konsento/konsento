namespace :utils do
  namespace :backup do
    desc "Backup teams"

    task :teams => :environment do
      teams = Team.all
      all_teams = ""

      teams.each do |team|
        all_teams += team.to_json + "\n"
      end

      File.open("teams.txt", "w") do |f|
        f.write all_teams
      end
    end
  end
end
