class SiteStatusController < ApplicationController
  def assigned_sites
    sites = UserService.emr_assigned_sites(params[:user_id])
    render json: sites
  end

  def create
    render json: UserService.update_assigned_site(params)
  end

  def assigned_emr_sites
    render json: UserService.assigned_emr_sites(params)
  end

end
