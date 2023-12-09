class ApplicationController < ActionController::API

  protected

  def auth_user
    
  end

  def decode_token
    # JWT.decode...

    # Authenticar de nuevo el useuario
  end

  def encode_token(user_email)
    # Codificar el token
    user = {email: user_email}

    JWT.encode(user, 'S3CR3T', 'HS256')
  end
end
