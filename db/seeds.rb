# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
ActiveRecord::Base.transaction do
  user = User.create(username: "Ruiz", email: "email@email.com", password: "123456")

  join = JoinRequirement.create(title: "CPF");

  req =  RequirementValue.create(user: user, join_requirement: join, value: 12345678900)

  group = Group.create(parent_id: nil, title: "Global", description: "Global group.")


  topic = Topic.create(user: user, group: group, title: "Sample Topic")
end
