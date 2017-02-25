class DevicesController < ApplicationController
  def index
    render json: Device.all.to_json
  end
end
