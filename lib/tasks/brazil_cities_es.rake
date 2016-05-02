namespace :utils do
  namespace :cities do
    desc "Insert ES cities into database"

    task :es => :environment do
      cities = [
        "Afonso Cláudio",
        "Água Doce do Norte",
        "Águia Branca",
        "Alegre",
        "Alfredo Chaves",
        "Alto Rio Novo",
        "Anchieta",
        "Apiacá",
        "Aracruz",
        "Atílio Vivácqua",
        "Baixo Guandu",
        "Barra de São Francisco",
        "Boa Esperança",
        "Bom Jesus do Norte",
        "Brejetuba",
        "Cachoeiro de Itapemirim",
        "Cariacica",
        "Castelo",
        "Colatina",
        "Conceição da Barra",
        "Conceição do Castelo",
        "Divino de São Lourenço",
        "Domingos Martins",
        "Dores do Rio Preto",
        "Ecoporanga",
        "Fundão",
        "Governador Lindenberg",
        "Guaçuí",
        "Guarapari",
        "Ibatiba",
        "Ibiraçu",
        "Ibitirama",
        "Iconha",
        "Irupi",
        "Itaguaçu",
        "Itapemirim",
        "Itarana",
        "Iúna",
        "Jaguaré",
        "Jerônimo Monteiro",
        "João Neiva",
        "Laranja da Terra",
        "Linhares",
        "Mantenópolis",
        "Marataízes",
        "Marechal Floriano",
        "Marilândia",
        "Mimoso do Sul",
        "Montanha",
        "Mucurici",
        "Muniz Freire",
        "Muqui",
        "Nova Venécia",
        "Pancas",
        "Pedro Canário",
        "Pinheiros",
        "Piúma",
        "Ponto Belo",
        "Presidente Kennedy",
        "Rio Bananal",
        "Rio Novo do Sul",
        "Santa Leopoldina",
        "Santa Maria de Jetibá",
        "Santa Teresa",
        "São Domingos do Norte",
        "São Gabriel da Palha",
        "São José do Calçado",
        "São Mateus",
        "São Roque do Canaã",
        "Serra",
        "Sooretama",
        "Vargem Alta",
        "Venda Nova do Imigrante",
        "Viana",
        "Vila Pavão",
        "Vila Valério",
        "Vila Velha",
        "Vitória"
      ]
      gl = Location.find_by(title: "Global", parent: nil)
      br = Location.find_by(title: "Brasil", parent: gl)
      st = Location.find_by(title: "Espírito Santo", parent: br)

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
