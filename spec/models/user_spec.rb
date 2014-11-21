# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  admin                  :boolean
#  guide_status           :integer
#  first                  :string(255)
#  last                   :string(255)
#  email                  :string(255)
#  phone                  :string(255)
#  birthday               :date
#  gender                 :string(255)
#  street_address         :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  emergency_first        :string(255)
#  emergency_last         :string(255)
#  emergency_relationship :string(255)
#  emergency_phone        :string(255)
#  emergency_email        :string(255)
#  emergency_notes        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  customer_uri           :string(255)
#  slug                   :string(255)
#  accept_terms           :boolean
#  active                 :boolean
#  registration_agreement :string(255)
#  client_agreement       :string(255)
#

require "spec_helper"

describe User do

	# Validations

	it "is invalid without a first name" do
		expect( FactoryGirl.build :user, first: nil ).not_to be_valid
	end

	it "is invalid without a last name" do
		expect( FactoryGirl.build :user, last: nil ).not_to be_valid
	end

	it "is invalid without an email" do
		expect( FactoryGirl.build :user, email: nil ).not_to be_valid
	end

	it "is invalid without accepting the terms of service" do
		expect( FactoryGirl.build :user, accept_terms: false ).not_to be_valid
	end


	# Methods

	it "returns a user's full name with full_name" do
		user = FactoryGirl.build(:user, first: "John", last: "Doe")
		expect( user.full_name ).to eq "John Doe"
	end


	# Model attributes
	
	let (:user) { FactoryGirl.build(:user) }

	subject { user }

  it { should be_valid }
	it { should respond_to :first }
	it { should respond_to :last }
	it { should respond_to :email }
	it { should respond_to :phone }
	it { should respond_to :street_address }
	it { should respond_to :city }
	it { should respond_to :state }
	it { should respond_to :emergency_first }
	it { should respond_to :emergency_last }
	it { should respond_to :emergency_relationship }
	it { should respond_to :emergency_phone }
	it { should respond_to :emergency_email }
	it { should respond_to :emergency_notes }
	it { should respond_to :slug }
	it { should respond_to :accept_terms }
	it { should respond_to :full_name }

end
