namespace :utils do
  namespace :backup do
    desc "Backup users"

    task :users => :environment do
      users = User.all
      all_users = ""

      users.each do |user|
        all_users += user.to_json + "\n"
      end

      File.open("users.txt", "w") do |f|
        f.write all_users
      end
    end
  end
end
