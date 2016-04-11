Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '216215862051535', '25045db171e0e61b22db0d8ecf65f008'
end
