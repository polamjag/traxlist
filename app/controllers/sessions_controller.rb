class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by(provider: auth["provider"], uid: auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:oauth_token] = auth.credentials.token
    session[:oauth_token_secret] = auth.credentials.secret
    session[:user_info] = auth.extra
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session = []
    p session
    redirect_to :root
  end
end
