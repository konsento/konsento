namespace :utils do
  namespace :cities do
    desc "Insert MS cities into database"

    task :ms => :environment do
      cities = [
        "Água Clara",
        "Alcinópolis",
        "Amambai",
        "Anastácio",
        "Anaurilândia",
        "Angélica",
        "Antônio João",
        "Aparecida do Taboado",
        "Aquidauana",
        "Aral Moreira",
        "Bandeirantes",
        "Bataguaçu",
        "Batayporã",
        "Bela Vista",
        "Bodoquena",
        "Bonito",
        "Brasilândia",
        "Caarapó",
        "Camapuã",
        "Campo Grande",
        "Caracol",
        "Cassilândia",
        "Chapadão do Sul",
        "Corguinho",
        "Coronel Sapucaia",
        "Corumbá",
        "Costa Rica",
        "Coxim",
        "Deodápolis",
        "Dois Irmãos do Buriti",
        "Douradina",
        "Dourados",
        "Eldorado",
        "Fátima do Sul",
        "Figueirão",
        "Glória de Dourados",
        "Guia Lopes da Laguna",
        "Iguatemi",
        "Inocência",
        "Itaporã",
        "Itaquiraí",
        "Ivinhema",
        "Japorã",
        "Jaraguari",
        "Jardim",
        "Jateí",
        "Juti",
        "Ladário",
        "Laguna Carapã",
        "Maracaju",
        "Miranda",
        "Mundo Novo",
        "Naviraí",
        "Nioaque",
        "Nova Alvorada do Sul",
        "Nova Andradina",
        "Novo Horizonte do Sul",
        "Paraíso das Águas",
        "Paranaíba",
        "Paranhos",
        "Pedro Gomes",
        "Ponta Porã",
        "Porto Murtinho",
        "Ribas do Rio Pardo",
        "Rio Brilhante",
        "Rio Negro",
        "Rio Verde de Mato Grosso",
        "Rochedo",
        "Santa Rita do Pardo",
        "São Gabriel do Oeste",
        "Selvíria",
        "Sete Quedas",
        "Sidrolândia",
        "Sonora",
        "Tacuru",
        "Taquarussu",
        "Terenos",
        "Três Lagoas",
        "Vicentina"
      ]
      gl = Location.find_by(title: "Global", parent: nil)
      br = Location.find_by(title: "Brasil", parent: gl)
      st = Location.find_by(title: "Mato Grosso do Sul", parent: br)

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
