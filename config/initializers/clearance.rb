Clearance.configure do |config|
  config.allow_sign_up = true
  # config.cookie_domain = 'konsento.org'
  # config.cookie_expiration = lambda { |cookies| 1.year.from_now.utc }
  # config.cookie_name = 'konsento_remember_token'
  # config.cookie_path = '/'
  config.routes = false
  # config.httponly = false
  config.mailer_sender = 'noreply@konsento.org'
  # config.password_strategy = Clearance::PasswordStrategies::BCrypt
  # config.redirect_url = '/'
  # config.secure_cookie = false
  # config.sign_in_guards = []
  # config.user_model = User

  Clearance::PasswordsController.layout 'pages'
  Clearance::SessionsController.layout 'pages'
  Clearance::UsersController.layout 'pages'
end
