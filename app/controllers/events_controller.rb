class EventsController < ApplicationController
  before_action :load_device
  before_action :load_event, only: [:respeak]
  before_action :authenticate_user!

  def index
    @events = @device.events.limit(20) unless @device.nil?
    respond_to do |format|
      format.json { render json: @events.to_json }
      format.html
    end
  end

  def new
    if params[:label].blank? || @device.blank?
      head :bad_request
      return
    end

    event = Event.new(label: params[:label], device_id: @device.id)
    event.save

    if event.errors.any?
      render text: "Error: #{event.errors.to_a.inspect}"
      return
    end

    render text: 'Registered'
    SpeechEngine.say(event.pretty_label, volume: proper_volume) if @device.speak_events?
  end

  def respeak
    SpeechEngine.say(@event.pretty_label)
    head :ok # pure remote method, don't care about success
  end

  private

  def load_device
    return if params[:device_id].blank?
    @device = if params[:device_id].match?(/^\d+$/)
                Device.find_by(id: params[:device_id])
              end
    @device ||= Device.where(['name like ?', params[:device_id]]).first
    @device ||= Device.where(['MD5(name) like ?', params[:device_id]]).first
  end

  def load_event
    return if params[:event_id].blank?
    @event = Event.find(params[:event_id])
  end

  def proper_volume
    # 9am to 8pm
    if (9..19).cover?(Time.now.in_time_zone.hour)
      80
    else
      60
    end
  end
end
