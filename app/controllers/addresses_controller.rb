class AddressesController < ApplicationController
  before_action :set_address, only: %i[ show edit update destroy ]

  # GET /addresses or /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1 or /addresses/1.json
  def show
    key = @address.zip_code
    # if Redis key expires, get new forecast data
    @address.save_forecasts if !Rails.cache.exist?(key)
    @forecasts  = Rails.cache.read(key)
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses or /addresses.json
  def create
    @address = Address.new(address_params)

    respond_to do |format|
      if @address.save
        if @address.longitude && @address.latitude
          @address.save_forecasts if !Rails.cache.exist?(@address.zip_code)
          format.html { redirect_to @address, notice: "Address was successfully created." }
        else
          format.html { redirect_to @address, alert: "Address was successfully created but can not get weather forecast." }
        end
        
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        @address.save_forecasts if !Rails.cache.exist?(@address.zip_code)
        format.html { redirect_to @address, notice: "Address was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    @address.destroy!

    respond_to do |format|
      format.html { redirect_to addresses_path, notice: "Address was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.expect(address: [ :street_address, :city, :state, :zip_code ])
    end
end
