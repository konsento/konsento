namespace :utils do
  namespace :cities do
    desc "Insert RR cities into database"

    task :rr => :environment do
      cities = [
        "Alto Alegre",
        "Amajari",
        "Boa Vista",
        "Bonfim",
        "Cantá",
        "Caracaraí",
        "Caroebe",
        "Iracema",
        "Mucajaí",
        "Normandia",
        "Pacaraima",
        "Rorainópolis",
        "São João da Baliza",
        "São Luís",
        "Uiramutã"
      ]
      gl = Location.find_by(title: "Global", parent: nil)
      br = Location.find_by(title: "Brasil", parent: gl)
      st = Location.find_by(title: "Roraima", parent: br)

      cities.each do |city|
        Location.create!(
          parent: st,
          title: city,
          description: "Cidade de " + city,
          total_votes_percent: 50,
          agree_votes_percent: 50
        )
      end
    end
  end
end
