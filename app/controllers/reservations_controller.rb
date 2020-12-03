class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :get_property, only: [:new, :create]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    case current_user.role.name
    when 'host'
      @reservations = Reservation.joins(:property, :user).where("properties.user_id = ?", current_user.id)
    when 'guest'
      @reservations = current_user.reservations
    end
  end
  # GET /reservation/new
  def new
    @reservation = @property.reservations.build
  end

  # GET /reservations/1.json
  def show
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if params[:reservation][:number_of_nights] != @reservation.number_of_nights then
        @reservation.total_price =  params[:reservation][:number_of_nights].to_d * @reservation.property.price_per_night
      end
      if @reservation.update(reservation_params)
        format.html { redirect_to reservations_path, notice: 'Reservation was successfully updated.' }
        format.json { render :index, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end


  # POST /reservation
  # POST /reservation.json
  def create
    @reservation = @property.reservations.build(reservation_params)
    @reservation.user = current_user
    @reservation.total_price = @reservation.number_of_nights * @property.price_per_night
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

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation =  @property ? @property.reservations.find(params[:id]) : Reservation.find(params[:id])
      if (current_user.role.name == 'guest' && @reservation.user != current_user) then
        redirect_to reservations_path
      end
      if (current_user.role.name == 'host' && @reservation.property.user_id != current_user.id)
        redirect_to reservations_path
      end
    end

    def get_property
      @property = Property.find(params[:property_id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:reservation_date, :number_of_nights, :number_of_guest, :approved)
    end

    def record_not_found
      render plain: "404 Not Found", status: 404
    end
end
