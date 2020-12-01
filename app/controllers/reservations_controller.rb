class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_property, only: [:new, :create, :update]
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def index
    @reservations = current_user.reservations
  end
  # GET /reservation/new
  def new
    @reservation = @property.reservations.build
  end

  # POST /reservation
  # POST /reservation.json
  def create
    @reservation = @property.reservations.build(reservation_params)
    @reservation.user = current_user
    respond_to do |format|
      if @reservation.save
        format.html { redirect_to property_reservations_path(@property), notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = @property.reservations.find(params[:id])
    end

    def get_property
      @property = Property.find(params[:property_id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:reservation_date, :number_of_nights, :number_of_guest)
    end
end
