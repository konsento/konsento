namespace :utils do
  namespace :backup do
    desc "Backup all relevant entities from database"

    task :every => [ "utils:backup:comments", "utils:backup:proposals",
                     "utils:backup:topics", "utils:backup:users",
                     "utils:backup:votes", "utils:backup:teams" ]
  end
end
