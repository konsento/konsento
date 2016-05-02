namespace :utils do
  namespace :cities do
    desc "Insert RO cities into database"

    task :ro => :environment do
      cities = [
        "Alta Floresta d'Oeste",
        "Alto Alegre dos Parecis",
        "Alto Paraíso",
        "Alvorada d'Oeste",
        "Ariquemes",
        "Buritis",
        "Cabixi",
        "Cacaulândia",
        "Cacoal",
        "Campo Novo de Rondônia",
        "Candeias do Jamari",
        "Castanheiras",
        "Cerejeiras",
        "Chupinguaia",
        "Colorado do Oeste",
        "Corumbiara",
        "Costa Marques",
        "Cujubim",
        "Espigão d'Oeste",
        "Governador Jorge Teixeira",
        "Guajará-Mirim",
        "Itapuã do Oeste",
        "Jaru",
        "Ji-Paraná",
        "Machadinho d'Oeste",
        "Ministro Andreazza",
        "Mirante da Serra",
        "Monte Negro",
        "Nova Brasilândia d'Oeste",
        "Nova Mamoré",
        "Nova União",
        "Novo Horizonte do Oeste",
        "Ouro Preto do Oeste",
        "Parecis",
        "Pimenta Bueno",
        "Pimenteiras do Oeste",
        "Porto Velho",
        "Presidente Médici",
        "Primavera de Rondônia",
        "Rio Crespo",
        "Rolim de Moura",
        "Santa Luzia d'Oeste",
        "São Felipe d'Oeste",
        "São Francisco do Guaporé",
        "São Miguel do Guaporé",
        "Seringueiras",
        "Teixeirópolis",
        "Theobroma",
        "Urupá",
        "Vale do Anari",
        "Vale do Paraíso",
        "Vilhena"
      ]
      gl = Location.find_by(title: "Global", parent: nil)
      br = Location.find_by(title: "Brasil", parent: gl)
      st = Location.find_by(title: "Rondônia", parent: br)

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
