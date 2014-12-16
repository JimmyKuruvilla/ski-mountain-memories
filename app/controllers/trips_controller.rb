class TripsController < ApplicationController
  protect_from_forgery :except => [:show, :new]

  def show
    @trip = Trip.friendly.find(params[:id])
    @lat = @trip.mountain.lat
    @lng = @trip.mountain.lng
    @zoom_level = @trip.mountain.zoom_level
    @visuals = @trip.visuals
  end

  def edit
  end

  def update
  end

  def new
    @trip = Trip.new
   end

  def create
    if params[:trip][:mountain_id]=="" #no mountain entered
      @message="please select a mountain"
    else
      trip = Trip.new(mountain_id: params[:trip][:mountain_id], hashtag: params[:trip][:hashtag])
      trip.users << current_user
      if !trip.save #couldn't save.
      # JJK: I think this kind of behavior should be handled in the model and then written to ERRORS, and ERROrs should be in the view
        @message="please select another hashtag"
      else
        Instagram.create_subscription("tag", "http://skima.herokuapp.com/sessions/sub_callback", object_id: trip.hashtag)
        redirect_to trip_path(trip.id) and return
      end
    end
      redirect_to new_trip_path, notice: @message
    end
    

  def addvisuals
    @trip=Trip.friendly.find(params[:trip_id])
    @visuals=@trip.visuals.all.select {|visual| true}

    @profile_pics=@visuals.collect do |visual| 
      visual.profile_pic if visual.trip_id == @trip.id
    end

  end

  def genhashtag
    @newhashtag=Trip.genhashtag
  end

  def showphotos
  end

  def clearphotos
  end

  # def copytoclipboard
  #   @trip=Trip.first
  #   # Trip.friendly.find(params[:trip_id])
  # end

end
