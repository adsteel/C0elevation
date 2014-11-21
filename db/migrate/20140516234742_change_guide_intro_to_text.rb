class ChangeGuideIntroToText < ActiveRecord::Migration
  def change
  	change_column :guides, :intro, :text
  end
end
