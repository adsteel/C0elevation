class Trips::TripImagesController < ApplicationController
	before_action :set_trip
	before_action :set_image, only: [:show, :edit, :update, :destroy]
	before_action :set_ratios, only: [:edit, :new, :create, :update]

	def index
		@image = @trip.images.first
		@images = @trip.images.all
	end

	def show
	end

	def new
		@image = Image.new
	end

	def edit
	end

	def create
		@image = Image.new(image_params)
		@image.trip_id = @trip.id
		@image.uploaded_by_user_id = current_user.id
		respond_to do |format|
			if @image.save
				update_images(@trip, @image)
				format.html { redirect_to trip_image_path(@trip, @image), notice: 'Image was successfully created.' }
				format.json { render action: 'show', status: :created, location: @image }
			else
				format.html { render action: 'new' }
				format.json { render json: @image.errors, status: :unprocessable_entity }
			end
		end
	end

	def update		
		respond_to do |format|
			if @image.update(image_params)
				update_images(@trip, @image)
				format.html { redirect_to trip_image_path(@trip, @image), notice: 'Image was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @image.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@image.destroy
		respond_to do |format|
			format.html { redirect_to trip_images_path(@trip) }
			format.json { head :no_content }
		end
	end

	private

		def set_image
			@image = Image.find(params[:id])
		end

		def set_trip
			@trip = Trip.friendly.find(params[:trip_id])
		end

		def set_ratios
			@ratios = Image::RATIOS
		end

		def image_params
			params.require(:image).permit(  :activity_id,
											:location_id,
											:feature_id,
											:route_id,
											:client_id,
											:guide_id,
											:trip_id,
											:company_id,
											:image,
											:asset,
											:description,
											:ratio)
		end

		def update_images(trip, image)
			trip.update({:primary_image_id => image.id }) if (params[:primary] || trip.primary_image.blank? )
			trip.update({:banner_image_id => image.id }) if params[:banner]
		end
end
