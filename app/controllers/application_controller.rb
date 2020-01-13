class ApplicationController < ActionController::Base
  before_action :authenticate_user_state, except: [:login, :signup, :create]
  skip_before_action :verify_authenticity_token


  protected

  def authenticate_user_state
    if session[:user_id].blank?
      redirect_to '/login'
    else
      User.current = User.find session[:user_id]
    end
  end

end
