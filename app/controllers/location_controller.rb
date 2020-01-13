class LocationController < ApplicationController
  def index
  end

  def show
    render json: LocationService.emr_list
  end

end
