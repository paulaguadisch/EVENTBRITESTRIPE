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
      redirect_to @event
    end

  @amount = @event.price

  customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Paiement de #{@user.username}',
    :currency    => 'eur'
  )

  @event.user_attendees << current_user
  redirect_to @event

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to @event
  end


	def event_params
		params.require(:event).permit(:name, :description, :date, :place)
	end
end
