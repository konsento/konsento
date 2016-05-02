namespace :utils do
  namespace :cities do
    desc "Insert SE cities into database"

    task :se => :environment do
      cities = [
        "Amparo de São Francisco",
        "Aquidabã",
        "Aracaju",
        "Arauá",
        "Areia Branca",
        "Barra dos Coqueiros",
        "Boquim",
        "Brejo Grande",
        "Campo do Brito",
        "Canhoba",
        "Canindé de São Francisco",
        "Capela",
        "Carira",
        "Carmópolis",
        "Cedro de São João",
        "Cristinápolis",
        "Cumbe",
        "Divina Pastora",
        "Estância",
        "Feira Nova",
        "Frei Paulo",
        "Gararu",
        "General Maynard",
        "Graccho Cardoso",
        "Ilha das Flores",
        "Indiaroba",
        "Itabaiana",
        "Itabaianinha",
        "Itabi",
        "Itaporanga d'Ajuda",
        "Japaratuba",
        "Japoatã",
        "Lagarto",
        "Laranjeiras",
        "Macambira",
        "Malhada dos Bois",
        "Malhador",
        "Maruim",
        "Moita Bonita",
        "Monte Alegre de Sergipe",
        "Muribeca",
        "Neópolis",
        "Nossa Senhora Aparecida",
        "Nossa Senhora da Glória",
        "Nossa Senhora das Dores",
        "Nossa Senhora de Lourdes",
        "Nossa Senhora do Socorro",
        "Pacatuba",
        "Pedra Mole",
        "Pedrinhas",
        "Pinhão",
        "Pirambu",
        "Poço Redondo",
        "Poço Verde",
        "Porto da Folha",
        "Propriá",
        "Riachão do Dantas",
        "Riachuelo",
        "Ribeirópolis",
        "Rosário do Catete",
        "Salgado",
        "Santa Luzia do Itanhy",
        "Santana do São Francisco",
        "Santa Rosa de Lima",
        "Santo Amaro das Brotas",
        "São Cristóvão",
        "São Domingos",
        "São Francisco",
        "São Miguel do Aleixo",
        "Simão Dias",
        "Siriri",
        "Telha",
        "Tobias Barreto",
        "Tomar do Geru",
        "Umbaúba"
      ]
      gl = Location.find_by(title: "Global", parent: nil)
      br = Location.find_by(title: "Brasil", parent: gl)
      st = Location.find_by(title: "Sergipe", parent: br)

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
