class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :location, :primary_key => :location_id do |t|
      t.bigint    :location_type_id, null: false
      t.string    :name, null: false
      t.string    :latitude
      t.string    :longitude
      t.integer   :parent_location
      t.boolean   :active, null: false, default: 1

      t.timestamps
    end
  end

  def down
    drop_table  :location
  end
end
