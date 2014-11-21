class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.string :user_id
      t.string :intro
      t.string :bio
      t.boolean :approved
      t.boolean :banned

      t.timestamps
    end
  end
end
