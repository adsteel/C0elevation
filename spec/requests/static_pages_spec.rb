require 'spec_helper'

describe "Static Pages" do
  before(:each) do
    @activities = create(:activity)
    @privacy_policy = create(:registration_agreement)
    @terms_of_service = create(:client_agreement)
    company_default = double(Company, id: 4, refund_policy: 'refund_policy')
    allow(Company).to receive(:find).and_return(company_default)
    @cart_items = create(:order_item, order_id: nil)
  end
  
  describe "Home Page" do
    before(:each) do
      @everest_trek       = create(:trip, id: 7)
      @langtang_trek      = create(:trip, id: 9)
      @manaslu_trek       = create(:trip, id: 8)
      @apex_longs_2_day   = create(:trip, id: 12)
      @apex_longs_1_day   = create(:trip, id: 13)
      @apex_basic_rock    = create(:trip, id: 10)
      @tenmile_mb         = create(:trip, id: 16)
      @tenmile_fly        = create(:trip, id: 14)
      @tenmile_mb_group   = create(:trip, id: 17)
      allow(Trip).to receive(:primary_image_url) { "url" }
      allow(Trip).to receive(:banner_image_url) { "url" }
    end
    
    context "when I visit" do
      before(:each) do
        visit "/static_pages/home"
      end
      
      it "should have the correct content" do
        expect(page).to have_content "Professional Guides"
        expect(page).to have_content "2014 Group Trips"
        expect(page).to have_content "2014 Private Trips"
        expect(page).to have_content "Connecting you with adventure"
        expect(page).to have_content "Sign In"
        expect(page).to have_content "| Sign Up"
      end
      
      it "faq link should be accurate" do
        click_link "faqs"
        expect(current_path).to eq(faqs_path)
      end

      it "contact link should be accurate" do
        click_link "contact"
        expect(current_path).to eq(contact_path)
      end

      it "about us link should be accurate" do
        click_link "about us"
        expect(current_path).to eq(about_path)
      end

      it "home link should be accurate" do
        click_link "home"
        expect(current_path).to eq(home_path)
      end

      it "logo link should take us home" do
        click_link "logo_link"
        expect(current_path).to eq(home_path)
      end

      it "guides wanted link should be accurate" do
        click_link "Guides Wanted"
        expect(current_path).to eq(guides_application_path)
      end

        context "if I'm signed in" do
          before(:each) do
        		@user = create(:user)
        		login_as @user
            visit "/static_pages/home"
          end
          
          it "should have the correct content" do
            expect(page).to have_content "Howdy, "
            expect(page).to have_link "My Account"
            expect(page).to have_link "Sign out"
          end
          
          it "should not have incorrect content" do
            expect(page).to_not have_link "Admin Dashboard"
          end
        end
        
        context "if I'm an administrator" do
          before(:each) do
        		admin = create(:admin)
        		login_as admin
            visit "/static_pages/home"
          end
          
          it "should have correct content" do
            expect(page).to have_link "Admin Dashboard"
          end
        end

    end
  end

  describe "FAQ Page" do
    context "when I visit" do
      it "should have the correct content" do    
        visit faqs_path
        within all('h1')[0] do
           expect(page).to have_content "FAQ"
         end
        expect(page).to have_content "Should I tip my guide?"
        expect(page).to have_content "How do I cancel?"
      end
    end
  end
  
  describe "About Page" do
    context "when I visit" do
      it "should have the correct content" do
        visit about_path
        within all('h1')[0] do
           expect(page).to have_content "About us"
         end
        expect(page).to have_content "coElevation"
      end
    end
  end
  
  describe "Contact Page" do
    context "when I visit" do
      it "should have the correct content" do
        visit contact_path
        within all('h1')[0] do
           expect(page).to have_content "Contact"
         end
        expect(page).to have_content "General inquiries"
      end
    end
  end
  
  describe "Guide Apply Page" do
    context "when I visit" do
      it "should have the correct content" do
        visit guides_application_path
        within all('h1')[0] do
           expect(page).to have_content "Apply as a Guide"
         end
        expect(page).to have_content "professional"
      end
    end
  end
  
end