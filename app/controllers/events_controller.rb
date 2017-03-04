class EventsController < ApplicationController
  before_action :load_device

  def index
    @events = @device.events.order('id DESC').limit(20) unless @device.nil?
    respond_to do |format|
      format.json { render json: @events.to_json }
      format.html
    end
  end

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
        SpeechEngine.say(params[:l], volume: proper_volume)
      end
    end
  end

  def respeak
    return if params[:e].blank?
    event = Event.find(params[:e])
    SpeechEngine.say(event.label)
  ensure
    redirect_back fallback_location: root_path
  end

  private

  def load_device
    return if params[:d].blank?
    @device = if params[:d].match?(/^\d+$/)
                Device.find_by(id: params[:d])
              else
                Device.where(['name like ?', "%#{params[:d]}%"]).first
              end
  end

  def proper_volume
    # 9am to 8pm
    if (9..19).cover?(Time.now.in_time_zone.hour)
      80
    else
      50
    end
  end
end
