class CreateAttractions < ActiveRecord::Migration[5.2]
  def change
    create_table :attractions do |t|
      t.string :name
      t.string :tickets
      t.string :nausea_rating
      t.string :happiness_rating
      t.string :min_height

      t.timestamps
    end
  end
end
