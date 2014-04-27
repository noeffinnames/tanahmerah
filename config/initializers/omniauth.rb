require 'omniauth-facebook'
#config.omniauth :facebook, FACEBOOK_KEY, FACEBOOK_SECRET

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], :auth_type => 'reauthenticate'
end
