ActiveRecord::Base.transaction do
  user1 = User.create!(username: "ruiz", email: "ruiz@email.com", password: "123456")
  user2 = User.create!(username: "anon", email: "anon@email.com", password: "123456")
  user3 = User.create!(username: "tanaka", email: "tanaka@email.com", password: "123456")

  join = JoinRequirement.create!(title: "CPF");

  req =  RequirementValue.create!(user: user1, join_requirement: join, value: '12345678900')

  group = Group.create!(parent: nil, title: "Global", description: "Global group.")

  group.join_requirements << join

  user1.subscriptions.create!(group: group)

  subgroup = Group.create!(parent: group, title: "National", description: "Global subgroup.")

  topic = Topic.create!(user: user1, group: group, title: "Sample Topic",
    proposals_attributes: [
      {
        user: user1,
        topic: topic,
        proposal_index: 0,
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam
        faucibus metus eu faucibus posuere. In massa tellus, auctor sit amet pretium
         et, lacinia eget velit. Praesent faucibus dignissim arcu, nec mattis quam
         vulputate eu. Nam est neque, ultrices nec tellus amet.".squish
      },
      {
        user: user1,
        topic: topic,
        proposal_index: 1,
        content: "Interdum et malesuada fames ac ante ipsum primis in faucibus.
        Integer euismod mollis erat, ac euismod nisi varius quis. Integer eu diam
        vel enim cursus ullamcorper. Lorem ipsum dolor sit amet, consectetur
        adipiscing elit. Cras venenatis felis ut nulla al consequat. ".squish
      },
      {
        user: user1,
        topic: topic,
        proposal_index: 2,
        content: "Nulla facilisi. Nulla in porta arcu. Phasellus bibendum cursus
        pellentesque. In tincidunt purus et ipsum facilisis, sit amet dignissim
        felis suscipit. Nullam sollicitudin mattis egestas. Donec convallis et risus
         varius porttitor. Sed id fermentum lorem amet Aliquam.".squish
      },
      {
        user: user1,
        topic: topic,
        proposal_index: 0,
        content: "Ligula et malesuada fames ac ante ipsum primis in faucibus.
        Proin quis lobortis sem. Mauris sed lorem sem. Curabitur et mattis est.
        Vestibulum enim ligula, mollis vel ultricies eu, aliquet quis ex. Maecenas
        bibendum rutrum rhoncus. In sapien tortor, consectetur.".squish
      },
      {
        user: user1,
        topic: topic,
        proposal_index: 0,
        content: "Suspendisse eget laoreet purus. Aliquam facilisis nulla non justo
        hendrerit mattis. Cum sociis natoque penatibus et magnis dis parturient
        montes, nascetur ridiculus mus. Pellentesque a semper lectus. Aliquam rutrum
         mauris ac elit accumsan, vitae convallis tincidunt.".squish
      },
      {
        user: user1,
        topic: topic,
        proposal_index: 1,
        content: "Donec gravida feugiat aliquam. Proin sapien urna, malesuada a nibh
         sed, accumsan sagittis ipsum. Pellentesque euismod sagittis nunc ac
         interdum. Sed et sodales magna. Sed congue, dolor nec dignissim mattis,
         purus purus maximus dolore, non dictum metus dolor ac erat.".squish
      }
    ]
  )

  topic.proposals.fourth.update(parent: Proposal.first)
  topic.proposals.fifth.update(parent: Proposal.first)
  topic.proposals.last.update(parent: Proposal.second)
end
