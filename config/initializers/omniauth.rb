Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, ENV["OMNIAUTH_TWITTER_CK"], ENV["OMNIAUTH_TWITTER_CS"]
  provider :twitter, "uQ6aYq98FwXeipQL7JKnk11fC", "hOFPUEy9NWwFqeIa3ulGZMs5lObZ1J6JrbD5IGEGYat4FMiS6R"
end
