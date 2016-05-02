namespace :utils do
  desc "Insert US and Brazil States into database"
  # Taken from: http://www.nationsonline.org/oneworld/countries_of_the_world.htm

  task :states => :environment do
    # US States
    us_states = [
      "Alabama",
      "Alaska",
      "Arizona",
      "Arkansas",
      "California",
      "Colorado",
      "Connecticut",
      "Delaware",
      "Florida",
      "Georgia",
      "Hawaii",
      "Idaho",
      "Illinois",
      "Indiana",
      "Iowa",
      "Kansas",
      "Kentucky",
      "Louisiana",
      "Maine",
      "Maryland",
      "Massachusetts",
      "Michigan",
      "Minnesota",
      "Mississippi",
      "Missouri",
      "Montana",
      "Nebraska",
      "Nevada",
      "New Hampshire",
      "New Jersey",
      "New Mexico",
      "New York",
      "North Carolina",
      "North Dakota",
      "Ohio",
      "Oklahoma",
      "Oregon",
      "Pennsylvania",
      "Rhode Island",
      "South Carolina",
      "South Dakota",
      "Tennessee",
      "Texas",
      "Utah",
      "Vermont",
      "Virginia",
      "Washington",
      "West Virginia",
      "Wisconsin"
    ]
    us = Location.find_by_title("United States")

    us_states.each do |state|
      Location.create!(
        parent: us,
        title: state,
        description: "State of " + state,
        total_votes_percent: 50,
        agree_votes_percent: 50
      )
    end

    # Brasil States
    br_states = [
      "Acre",
      "Alagoas",
      "Amapá",
      "Amazonas",
      "Bahia",
      "Ceará",
      "Distrito Federal",
      "Espírito Santo",
      "Goiás",
      "Maranhão",
      "Mato Grosso",
      "Mato Grosso do Sul",
      "Minas Gerais",
      "Pará",
      "Paraíba",
      "Paraná",
      "Pernambuco",
      "Piauí",
      "Rio de Janeiro",
      "Rio Grande do Norte",
      "Rio Grande do Sul",
      "Rondônia",
      "Roraima",
      "Santa Catarina",
      "São Paulo",
      "Sergipe",
      "Tocantins"
    ]
    br = Location.find_by_title("Brasil")

    br_states.each do |state|
      Location.create!(
        parent: br,
        title: state,
        description: "Estado de " + state,
        total_votes_percent: 50,
        agree_votes_percent: 50
      )
    end
  end
end
