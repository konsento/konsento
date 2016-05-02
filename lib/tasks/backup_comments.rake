namespace :utils do
  namespace :backup do
    desc "Backup comments"

    task :comments => :environment do
      comments = Comment.all
      all_comments = ""

      comments.each do |comment|
        all_comments += comment.to_json + "\n"
      end

      File.open("comments.txt", "w") do |f|
        f.write all_comments
      end
    end
  end
end
