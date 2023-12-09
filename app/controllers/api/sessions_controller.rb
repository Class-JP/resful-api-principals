class Api::SessionsController < ApplicationController

  def signup
    @user = User.new(user_params)

    if @user.save
      new_token = encode_token(@user.email)
  
      render json: {message: 'User Created!', token: new_token}, status: 201
    else
      render json: @user.errors
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    new_token = encode_token(@user.email)

    if @user.present? && @user.authenticate(params[:password])
      render json: {message: 'User is loged in!', token: new_token}, status: 201
    else
      render json: {message: 'Incorrect Credentials'}
    end
  end

  def logout
    
  end

  private

  def user_params

    params.permit(:email, :password)
  end
end
