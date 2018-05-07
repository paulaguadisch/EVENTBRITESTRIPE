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

  def show
  	@event = Event.new
    @events = Event.all
  end

	def event_params
		params.require(:event).permit(:name, :description, :date, :place)
	end
end
