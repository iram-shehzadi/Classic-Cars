class CarsController < ApplicationController
	before_action :find_car, only: [:show, :edit, :update, :destroy]

	def index
		@cars = Car.all
  end


	def show

    @markers = [
      {
        lat: @car.latitude,
        lng: @car.longitude
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
	end

	def update
		@car.update(car_params)
		redirect_to car_path(@car)
	end

	def destroy
		@car.destroy
		redirect_to cars_path
	end

	private

	def car_params
		params.require(:car).permit(:manufacturer, :model, :year, :price, :rating, :description, :photo)
	end

	def find_car
		@car = Car.find(params[:id])
	end
end
