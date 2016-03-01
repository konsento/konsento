ActiveRecord::Base.transaction do
  user1 = User.create!(username: "ruiz", email: "ruiz@email.com", password: "123456")
  user2 = User.create!(username: "anon", email: "anon@email.com", password: "123456")
  user3 = User.create!(username: "tanaka", email: "tanaka@email.com", password: "123456")
  user4 = User.create!(username: "sandoval", email: "sandoval@email.com", password: "123456")

  join = JoinRequirement.create!(title: "CPF");

  RequirementValue.create!(user: user1, join_requirement: join, value: '12345678900')
  RequirementValue.create!(user: user2, join_requirement: join, value: '12345678901')
  RequirementValue.create!(user: user3, join_requirement: join, value: '12345678902')
  RequirementValue.create!(user: user4, join_requirement: join, value: '12345678903')

  team = Team.create(title: 'Sample Team', public: true)

  group = Group.create!(
    parent: nil,
    title: "Global",
    description: "Global group",
    total_votes_percent: 50,
    agree_votes_percent: 50
  )

  group.join_requirements << join

  user1.subscriptions.create!(subscriptable: group, role: 'default')
  user2.subscriptions.create!(subscriptable: group, role: 'default')
  user3.subscriptions.create!(subscriptable: group, role: 'default')
  user4.subscriptions.create!(subscriptable: group, role: 'default')

  subgroup = Group.create!(
    parent: group,
    title: "National",
    description: "Global subgroup",
    total_votes_percent: 50,
    agree_votes_percent: 50
  )

  topic = Topic.create!(user: user1, group: group, title: "Sample Topic", team: nil) do |t|
    s1 = t.sections.build(index: 0)
    s2 = t.sections.build(index: 1)
    s3 = t.sections.build(index: 2)

    p1 = s1.proposals.build(
      user: user1,
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam
      faucibus metus eu faucibus posuere. In massa tellus, auctor sit amet pretium
       et, lacinia eget velit. Praesent faucibus dignissim arcu, nec mattis quam
       vulputate eu. Nam est neque, ultrices nec tellus amet.".squish
    )

    p2 = s2.proposals.build(
      user: user1,
      content: "Interdum et malesuada fames ac ante ipsum primis in faucibus.
      Integer euismod mollis erat, ac euismod nisi varius quis. Integer eu diam
      vel enim cursus ullamcorper. Lorem ipsum dolor sit amet, consectetur
      adipiscing elit. Cras venenatis felis ut nulla al consequat. ".squish
    )

    p3 = s3.proposals.build(
      user: user1,
      content: "Nulla facilisi. Nulla in porta arcu. Phasellus bibendum cursus
      pellentesque. In tincidunt purus et ipsum facilisis, sit amet dignissim
      felis suscipit. Nullam sollicitudin mattis egestas. Donec convallis et risus
       varius porttitor. Sed id fermentum lorem amet Aliquam.".squish
    )

    s1.proposals.build(
      user: user1,
      parent: p1,
      content: "Ligula et malesuada fames ac ante ipsum primis in faucibus.
      Proin quis lobortis sem. Mauris sed lorem sem. Curabitur et mattis est.
      Vestibulum enim ligula, mollis vel ultricies eu, aliquet quis ex. Maecenas
      bibendum rutrum rhoncus. In sapien tortor, consectetur.".squish
    )

    s1.proposals.build(
      user: user1,
      parent: p1,
      content: "Suspendisse eget laoreet purus. Aliquam facilisis nulla non justo
      hendrerit mattis. Cum sociis natoque penatibus et magnis dis parturient
      montes, nascetur ridiculus mus. Pellentesque a semper lectus. Aliquam rutrum
       mauris ac elit accumsan, vitae convallis tincidunt.".squish
    )

    s2.proposals.build(
      user: user1,
      parent: p2,
      content: "Donec gravida feugiat aliquam. Proin sapien urna, malesuada a nibh
       sed, accumsan sagittis ipsum. Pellentesque euismod sagittis nunc ac
       interdum. Sed et sodales magna. Sed congue, dolor nec dignissim mattis,
       purus purus maximus dolore, non dictum metus dolor ac erat.".squish
    )
  end

  proposal1 = topic.sections.first.proposals.first
  proposal2 = topic.sections.second.proposals.first
  proposal3 = topic.sections.third.proposals.first

  Vote.create!(user: user2, proposal: proposal1, opinion: -1)
  Vote.create!(user: user2, proposal: proposal2, opinion: 1)
  Vote.create!(user: user2, proposal: proposal3, opinion: 0)

  Vote.create!(user: user3, proposal: proposal1, opinion: 1)
  Vote.create!(user: user3, proposal: proposal2, opinion: 1)
  Vote.create!(user: user3, proposal: proposal3, opinion: -1)

  Vote.create!(user: user4, proposal: proposal1, opinion: 0)
  Vote.create!(user: user4, proposal: proposal2, opinion: -1)
  Vote.create!(user: user4, proposal: proposal3, opinion: -1)
end
