set :stage, :production

role :app, "deploy@ec2-52-32-213-43.us-west-2.compute.amazonaws.com"
role :web, "deploy@ec2-52-32-213-43.us-west-2.compute.amazonaws.com"
role :db,  "deploy@ec2-52-32-213-43.us-west-2.compute.amazonaws.com"
