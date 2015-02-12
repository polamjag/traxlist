Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["OMNIAUTH_TWITTER_CK"], ENV["OMNIAUTH_TWITTER_CS"]
end
