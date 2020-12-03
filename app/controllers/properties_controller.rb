class PropertiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :authenticate_user!
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :validate_role, only: [:edit, :update, :destroy]
  def index
    case current_user.role.name
    when 'host'
      @properties = current_user.properties
    when 'guest'
      @properties = Property.all
    end
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @pictures = @property.pictures
  end

  # GET /galleries/new
  def new
    @property = current_user.properties.new
  end

  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)
    @property.user = current_user
    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_property
    @property = Property.find(params[:id])
    if (current_user.role.name == 'host' && @property.user != current_user) then
      redirect_to properties_path
    end
  end
  # Only allow a list of trusted parameters through.
  def property_params
    params.require(:property).permit(:title, :description, :price_per_night)
  end

  private

  def record_not_found
    render plain: "404 Not Found", status: 404
  end
  def validate_role
    if (current_user.role.name == 'guest') then
      redirect_to properties_path
    end
  end
end
