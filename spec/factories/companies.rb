# == Schema Information
#
# Table name: companies
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  hq_address        :string(255)
#  hq_city           :string(255)
#  hq_state          :string(255)
#  country           :string(255)
#  description       :text
#  phone             :string(255)
#  email             :string(255)
#  owner_id          :integer
#  contact_name      :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  active            :boolean
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  slug              :string(255)
#  refund_policy     :text
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

      factory :company do
        name
        hq_address "MyString"
        hq_city "MyString"
        hq_state "MyString"
        country "MyString"
        description
        phone "999999999"
        email
        owner
        contact_name "MyString"
        refund_policy "Refund policy"

        factory :bad_company do 
            name nil
            owner_id nil
        end
        
        factory :company_4 do
          id 4
        end
      end
end
