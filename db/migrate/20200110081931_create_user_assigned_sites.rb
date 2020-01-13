class CreateUserAssignedSites < ActiveRecord::Migration[5.2]
  def change
    create_table :user_assigned_sites do |t|
      t.bigint   :user_id, null: false
      t.bigint   :location_id, null: false
      t.boolean  :assigned , null: false

      t.timestamps
    end
  end

  def down
    drop_table  :user_assigned_sites
  end

end
