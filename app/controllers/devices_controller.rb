class DevicesController < ApplicationController
  def index
    @devices = Device.all
    respond_to do |format|
      format.json { render json: Device.all.to_json }
      format.html
    end
  end
end
