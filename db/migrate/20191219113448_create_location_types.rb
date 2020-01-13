class CreateLocationTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :location_type, :primary_key => :location_type_id do |t|
      t.string    :name, null: false
      t.string    :description

      t.timestamps
    end
  end

  def down
    drop_table  :location_type
  end
end
