class Admin::GuidesController < ApplicationController
  before_action :set_guide, only: [:show, :edit, :update, :destroy]
  before_action :confirm_signed_in
  before_action :set_users
  before_action :authenticate_guide, except: [:new, :create]
  before_action :authenticate_admin, only: [:index, :destroy]

  def index
    @guides = Guide.all
  end


  def show
    @user = @guide.user
    @trips = @guide.trips.load
  end


  def new
    @guide = Guide.new
  end


  def edit
  end


  def create
    @guide = Guide.new(guide_params)
    respond_to do |format|
      if @guide.save
        format.html { redirect_to admin_guide_path(@guide), notice: 'Your guide profile has been created.' }
        format.json { render action: 'show', status: :created, location: @guide }
      else
        format.html { render action: 'new' }
        format.json { render json: @guide.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @guide.update(guide_params)
        format.html { redirect_to  admin_guide_path(@guide), notice: 'Your guide profile has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @guide.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @guide.destroy
    respond_to do |format|
      format.html { redirect_to admin_guides_path }
      format.json { head :no_content }
    end
  end

  private
    def set_guide
      @guide = Guide.friendly.find(params[:id])
    end
    
    def set_users
      @users = User.all
    end

    def guide_params
      params.require(:guide).permit(:user_id,
        :intro,
        :bio,
        :approved,
        :banned,
        :accept_tems,
        :image )
    end
end
