class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_login_user, only: [:index, :new, :create]

  respond_to :html

  def index
    @events = @login_user.events
    # respond_with(@events)
  end

  def show
    respond_with(@event)
  end

  def new
    @act = params[:act]
    @event = Event.new
    respond_with(@event)
  end

  def edit
  end

  def create
    @login_user.events.create(event_params)
    respond_with(@event, location: calendar_index_path)
  end

  def update
    @event.update(event_params)
    respond_with(@event)
  end

  def destroy
    @event.destroy
    respond_with(@event)
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :message, :start, :end, :color, :orner, :allday, :category, :place, :address, :cost, :password)
    end

    def set_login_user
      @login_user = User.find(current_user.id)
    end
end
