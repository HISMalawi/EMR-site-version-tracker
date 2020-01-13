class UserController < ApplicationController
  def login
    if request.post?
      user = UserService.authenticate(params)
      if user
        session[:user_id] = user.id
        redirect_to root_path
        return
      end
    end

    reset_session
    render layout: false
  end

  def assign_site
    render json: UserService.assign_site(params)
  end

  def signup
    render layout: false
  end

  def create
    user = UserService.create(params)
    redirect_to '/login' unless user.blank?
    redirect_to '/signup' if user.blank?
  end

end
