ActiveRecord::Base.transaction do
  user1 = User.create(username: "ruiz", email: "ruiz@email.com", password: "123456")
  user2 = User.create(username: "anon", email: "anon@email.com", password: "123456")
  user3 = User.create(username: "tanaka", email: "tanaka@email.com", password: "123456")

  join = JoinRequirement.create(title: "CPF");

  req =  RequirementValue.create(user: user1, join_requirement: join, value: 12345678900)

  group = Group.create(parent: nil, title: "Global", description: "Global group.")

  subgroup = Group.create(parent: group, title: "National", description: "Global subgroup.")


  topic = Topic.create(user: user1, group: group, title: "Sample Topic")
end
