class AddAcceptConditionsColumnToGuide < ActiveRecord::Migration
  def change
  	add_column :guides, :accept_terms, :boolean
  end
end
