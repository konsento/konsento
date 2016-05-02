namespace :utils do
  namespace :cities do
    desc "Insert AM cities into database"

    task :am => :environment do
      cities = [
        "Alvarães",
        "Amaturá",
        "Anamã",
        "Anori",
        "Apuí",
        "Atalaia do Norte",
        "Autazes",
        "Barcelos",
        "Barreirinha",
        "Benjamin Constant",
        "Beruri",
        "Boa Vista do Ramos",
        "Boca do Acre",
        "Borba",
        "Caapiranga",
        "Canutama",
        "Carauari",
        "Careiro",
        "Careiro da Várzea",
        "Coari",
        "Codajás",
        "Eirunepé",
        "Envira",
        "Fonte Boa",
        "Guajará",
        "Humaitá",
        "Ipixuna",
        "Iranduba",
        "Itacoatiara",
        "Itamarati",
        "Itapiranga",
        "Japurá",
        "Juruá",
        "Jutaí",
        "Lábrea",
        "Manacapuru",
        "Manaquiri",
        "Manaus",
        "Manicoré",
        "Maraã",
        "Maués",
        "Nhamundá",
        "Nova Olinda do Norte",
        "Novo Aripuanã",
        "Novo Airão",
        "Parintins",
        "Pauini",
        "Presidente Figueiredo",
        "Rio Preto da Eva",
        "Santa Isabel do Rio Negro",
        "Santo Antônio do Içá",
        "São Gabriel da Cachoeira",
        "São Paulo de Olivença",
        "São Sebastião do Uatumã",
        "Silves",
        "Tabatinga",
        "Tapauá",
        "Tefé",
        "Tonantins",
        "Uarini",
        "Urucará",
        "Urucurituba"
      ]
      gl = Location.find_by(title: "Global", parent: nil)
      br = Location.find_by(title: "Brasil", parent: gl)
      st = Location.find_by(title: "Amazonas", parent: br)

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
