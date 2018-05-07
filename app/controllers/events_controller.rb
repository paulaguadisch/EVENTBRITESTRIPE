class EventsController < ApplicationController
  def new
  	@user = current_user
  	@event = Event.new
  end

  def create
  	@user = current_user
  	@event = Event.new(event_params)
  	@event.creator_id = @user.id
  	@event.save
  	redirect_to @user
  end

  def index
  	@event = Event.new
    @events = Event.all
  end

  def show
    @user = current_user
    @event = Event.find(params[:id])
  end

  def subscribe
    @user = current_user
    @event = Event.find(params[:id])
    if 
      @event.user_attendees.include? current_user
      flash[:error] = "Vous participez déjà à l'événement !" 
      redirect_to @event
    else
      @event.user_attendees << current_user
      flash[:success] = "Vous participez à l'événement !"
      redirect_to @event
    end
  end

	def event_params
		params.require(:event).permit(:name, :description, :date, :place)
	end
end
