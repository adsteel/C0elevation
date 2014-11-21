class ImagesController < ApplicationController
	before_action :set_image, only: [:show, :edit, :update, :destroy]


	def index
		@images = Image.all
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

		respond_to do |format|
			if @image.save
				format.html { redirect_to @image, notice: 'Image was successfully created.' }
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
				format.html { redirect_to @image, notice: 'Image was successfully updated.' }
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
			format.html { redirect_to images_url }
			format.json { head :no_content }
		end
	end

	private
		def set_image
			@image = Image.find(params[:id])
		end

		def image_params
			params.require(:image).permit(  :activity_id,
											:location_id,
											:feature_id,
											:route_id,
											:client_id,
											:guide_id,
											:trip_id, 
											:asset,
											:description,
											:ratio,
											:dimensions)
		end

end
