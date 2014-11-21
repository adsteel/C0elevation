class Admin::RegistrationAgreementsController < ApplicationController
  before_action :set_registration_agreement, only: [:show, :edit, :update, :destroy]

  def index
    @registration_agreements = RegistrationAgreement.all
  end

  def show
  end

  def new
    @registration_agreement = RegistrationAgreement.new
    @uniq_string = SecureRandom.hex
  end

  def create
    @registration_agreement = RegistrationAgreement.new(registration_agreement_params)

    respond_to do |format|
      if @registration_agreement.save
        format.html { redirect_to admin_registration_agreements_path, notice: 'Registration agreement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @registration_agreement }
      else
        format.html { render action: 'new' }
        format.json { render json: @registration_agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_registration_agreement
      @registration_agreement = RegistrationAgreement.find(params[:id])
    end

    def registration_agreement_params
      params.fetch(:registration_agreement, {}).permit(:uniq_name, :pdf)
    end
end
