namespace :utils do
  namespace :cities do
    desc "Insert all BR cities into database"

    task :every => [ "utils:cities:ac", "utils:cities:al", "utils:cities:am",
                     "utils:cities:ap", "utils:cities:ba", "utils:cities:ce",
                     "utils:cities:df", "utils:cities:es", "utils:cities:go",
                     "utils:cities:ma", "utils:cities:mg", "utils:cities:ms",
                     "utils:cities:mt", "utils:cities:pa", "utils:cities:pb",
                     "utils:cities:pe", "utils:cities:pi", "utils:cities:pr", 
                     "utils:cities:rj", "utils:cities:rn", "utils:cities:ro",
                     "utils:cities:rr", "utils:cities:rs", "utils:cities:sc",
                     "utils:cities:se", "utils:cities:sp", "utils:cities:to" ]
  end
end
