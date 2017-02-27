class EventsController < ApplicationController
  before_action :load_device

  def new
    if params[:l].blank? || @device.blank?
      render nothing: true
    else
      event = Event.new(label: params[:l], device_id: @device.id) 
      event.save
      if event.errors.any?
        render text: "Error: #{event.errors.to_a.inspect}"
      else
        render text: 'Registered'
        logger.debug "About to speak the sentence #{params[:l].inspect}"
        SpeechEngine.say params[:l]
      end
    end
  end
  
  def index
    @events = @device.events.order("id DESC").limit(20) unless @device.nil?
    respond_to do |format|
      format.json { render json: @events.to_json }
      format.html
    end
  end
  
private
  def load_device
    unless params[:d].blank?
      @device = (params[:d] =~ /^\d+$/) ? 
        TripSensor.find_by(id: params[:d]) :
        TripSensor.where(["name like ?", '%'+params[:d]+'%']).first
    end
  end
end
