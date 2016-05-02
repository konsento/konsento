namespace :utils do
  namespace :restore do
    desc "Restore backed up users"

    task :users => :environment do
      File.open("users.txt", "r") do |file|
        file.each_line do |l|
          user = User.new(JSON.parse(l))
          user.save!(validate: false)
        end
      end
    end
  end
end
