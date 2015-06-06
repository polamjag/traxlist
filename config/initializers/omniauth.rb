OmniAuth.config.full_host = "http://traxlist.polamjag.info" if Rails.env.production?

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["OMNIAUTH_TWITTER_CK"], ENV["OMNIAUTH_TWITTER_CS"]
end
