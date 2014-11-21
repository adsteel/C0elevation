class Admin::ClientAgreementsController < ApplicationController
  before_action :set_client_agreement, only: [:show, :edit, :update, :destroy]

  require 'securerandom'

  def index
    @client_agreements = ClientAgreement.all
  end

  
  def show
  end

  def new
    @client_agreement = ClientAgreement.new
    @uniq_string = SecureRandom.hex
  end

  def create
    @client_agreement = ClientAgreement.new(client_agreement_params)

    respond_to do |format|
      if @client_agreement.save
        format.html { redirect_to admin_client_agreements_path, notice: 'Client agreement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @client_agreement }
      else
        format.html { render action: 'new' }
        format.json { render json: @client_agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_client_agreement
      @client_agreement = ClientAgreement.find(params[:id])
    end

    def client_agreement_params
      params.require(:client_agreement).permit(
        :uniq_name,
        :pdf)
    end
end
