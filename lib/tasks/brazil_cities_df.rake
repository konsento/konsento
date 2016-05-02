namespace :utils do
  namespace :cities do
    desc "Insert DF cities into database"

    task :df => :environment do
      cities = [
        "Águas Claras",
        "Brasília",
        "Brazlândia",
        "Candangolândia",
        "Ceilândia",
        "Cruzeiro",
        "Fercal",
        "Gama",
        "Guará",
        "Itapoã",
        "Jardim Botânico",
        "Lago Norte",
        "Lago Sul",
        "Núcleo Bandeirante",
        "Paranoá",
        "Park Way",
        "Planaltina",
        "Recanto das Emas",
        "Riacho Fundo",
        "Riacho Fundo II",
        "Samambaia",
        "Santa Maria",
        "São Sebastião",
        "SCIA (Setor Complementar de Undústria e Abastecimento)",
        "SIA (Setor de Indústria e Abastecimento)",
        "Sobradinho",
        "Sobradinho II",
        "Sudoeste/Octagonal",
        "Taguatinga",
        "Varjão",
        "Vicente Pires"
      ]
      gl = Location.find_by(title: "Global", parent: nil)
      br = Location.find_by(title: "Brasil", parent: gl)
      st = Location.find_by(title: "Distrito Federal", parent: br)

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
