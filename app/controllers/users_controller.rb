class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new

    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "New user successfully created"
      redirect_to root_path   # <- if picture gets saved, generate a request to "/pictures"
    else
      render :new # <- otherwise render new.html.erb
    end
  end

end
