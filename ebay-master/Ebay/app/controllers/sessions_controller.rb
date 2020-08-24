class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create 
    @user = User.find_by(username: params[:username])
    if @user.nil?
      redirect_to action: 'login', phrase: 'Invalid Username'
    elsif @user.password == params[:password]
      session[:user_id] = @user.id 
      redirect_to @user
    else
      redirect_to action: 'login', phrase: 'Wrong Password'
    end
  end

  def login
    @phrase = params['phrase']
  end

  def destroy 
    reset_session
    redirect_to '/'
  end
end