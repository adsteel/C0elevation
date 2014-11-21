require 'spec_helper'

describe Admin::CompaniesController, :type => :controller do

	let(:admin) { create(:admin) }
	let(:company) { create(:company, owner_id: admin.id ) }

	before (:each) do
		sign_in admin
    company_default = double(Company, id: 4, refund_policy: 'refund_policy')
    allow(Company).to receive(:find).and_return(company_default)
	end

	describe "GET #index" do
		it "renders the :index view" do
			get :index
			expect( response ).to render_template :index
		end
	end

	describe "GET #new" do
		it "renders the :new view" do
			get :new
			expect( response ).to render_template :new
		end
	end

	describe "GET #show" do
		it "renders the :show view" do
			get :show, id: company
			expect( response ).to render_template :show
		end
	end

	describe "GET #edit" do
		it "renders the :edit view" do
			get :edit, id: company
			expect( response ).to render_template :edit
		end
	end

	describe "POST create action" do
		let(:user)				  { FactoryGirl.create(:user) }
		let(:company) 			{ attributes_for(:company, owner_id: user.id ) }
		let(:bad_company) 	{ attributes_for(:bad_company) }

		context "given valid attributes" do
			it "creates a new record" do
				expect{ post :create, company: company }.to change(Company, :count).by(1)
			end
		end

		context "given invalid attributes" do
			it "re-renders the new method" do
				post :create, company: bad_company
				expect( response ).to render_template :new
			end

			it "does not save the new record" do
				expect{ post :create, company: bad_company }.to_not change(Company, :count)
			end
		end

	end

	describe 'PUT update' do
		before :each do
			@company = create(:company, name: "Rockstars", phone: "3035551212")
		end
    
    let!(:companyD)  { create(:company, name: "Rockstard", phone: "303555121d") }

		context "valid attributes" do
			it "located the requested @company" do
				put :update, id: @company, company: attributes_for(:company)
				expect( assigns :company ).to eq @company
			end

			it "changes @company's attributes" do
        put :update, id: @company, company: attributes_for(:company, name: "Fishstars")
				@company = Company.find_by_id(@company)
        expect( @company.name ).to eq("Fishstars")
			end

			it "redirects to the updated company" do
				put :update, id: @company, company: attributes_for(:company)
				expect( response ).to redirect_to admin_company_path(@company)
			end

		end

		context "invalid attributes" do
			it "locates the requested @company" do
				put :update, id: @company, company: attributes_for(:bad_company)
				expect( assigns :company ).to eq @company
			end

			it "does not change @company's attributes" do
				put :update, id: @company, company: attributes_for(:company, name: nil, phone: "000000000")
				@company = Company.find_by_id(@company.id)
				expect( @company.name ).not_to eq(nil)
				expect( @company.phone ).to eq("3035551212")
			end

			it "re-renders the edit method" do
				put :update, id: @company, company: attributes_for(:bad_company)
				expect( response ).to render_template :edit
			end
		end
	end

end