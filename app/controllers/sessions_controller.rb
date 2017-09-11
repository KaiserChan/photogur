class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:redirect_url]
        redirect_url = session[:redirect_url]
        session[:redirect_url] = nil
        redirect_to redirect_url
      else
        redirect_to root_path, notice: "Logged in!"
      end
    else
      flash.now[:alert] = ["Login failed, name and/or password are incorrect"]
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end

end
