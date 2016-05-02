namespace :utils do
  namespace :restore do
    desc "Restore backed up comments"

    task :comments => :environment do
      File.open("comments.txt", "r") do |file|
        file.each_line do |l|
          comment = Comment.new(JSON.parse(l))
          comment.save!(validate: false)
        end
      end
    end
  end
end
