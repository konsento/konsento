namespace :utils do
  namespace :backup do
    desc "Restore all entities into database"

    task :every => [ "utils:restore:comments", "utils:restore:proposals",
                     "utils:restore:topics", "utils:restore:users",
                     "utils:restore:votes", "utils:restore:teams" ]
  end
end
