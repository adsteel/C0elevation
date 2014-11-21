# == Schema Information
#
# Table name: client_agreements
#
#  id               :integer          not null, primary key
#  uniq_name        :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  pdf_file_name    :string(255)
#  pdf_content_type :string(255)
#  pdf_file_size    :integer
#  pdf_updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client_agreement do
    uniq_name "MyString"
    pdf_file_name "file"
  end
end
