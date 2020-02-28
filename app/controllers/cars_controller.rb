class CarsController < ApplicationController
	before_action :find_car, only: [:show, :edit, :update, :destroy]
	before_action :check_owner_access, only: [:update, :destroy]

	def index
    if params[:query].present?
      @cars = Car.search_by_manufacturer_and_model_and_year(params[:query])
    else
      @cars = Car.all
    end
	end

	def show
    @markers = [
      {
        lat: @car.latitude,
        lng: @car.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { car: @car }),
        image_url: @car.photos.any? ? @car.photos.first.service_url : 'https://kitt.lewagon.com/placeholder/cities/random'
      }
    ]
		@review = Review.new
	end

	def new
		@car = Car.new
	end

	def create
		@car = Car.new(car_params)
    @car.user = current_user
		if @car.save
			redirect_to car_path(@car)
		else
			render :new
    end
	end

	def edit
		@car = Car.find(params[:id])
		if !owner?(@car)
			redirect_to "/"
		end
	end

	def update
		@car = Car.find(params[:id])
    @car.update(car_params)
		redirect_to car_path(@car)
	end

	def destroy
		@car.destroy
		redirect_to cars_path
	end

	private

	def car_params
		params.require(:car).permit(:manufacturer, :model, :year, :address, :price, :rating, :description, photos: [])
	end

	def find_car
		@car = Car.find(params[:id])
	end
end
