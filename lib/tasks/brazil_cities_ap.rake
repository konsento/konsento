namespace :utils do
  namespace :cities do
    desc "Insert AP cities into database"

    task :ap => :environment do
      cities = [
        "Amapá",
        "Calçoene",
        "Cutias",
        "Ferreira Gomes",
        "Itaubal",
        "Laranjal do Jari",
        "Macapá",
        "Mazagão",
        "Oiapoque",
        "Pedra Branca do Amapari",
        "Porto Grande",
        "Pracuuba",
        "Santana",
        "Serra do Navio",
        "Tartarugalzinho",
        "Vitória do Jari"
      ]
      gl = Location.find_by(title: "Global", parent: nil)
      br = Location.find_by(title: "Brasil", parent: gl)
      st = Location.find_by(title: "Amapá", parent: br)

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
