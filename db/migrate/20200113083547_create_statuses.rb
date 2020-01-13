class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.bigint   :site_status_id, null: false
      t.string   :version_number,  null: false
      t.boolean  :app_in_use, null: false, default: 0
      t.date     :last_date_used, null: false
      t.boolean  :data_up_to_date, null: false, default: 0
      t.boolean  :data_cleaning_done, null: false, default: 0
      t.text     :comments
      t.boolean  :voided, null: false, default: 0

      t.timestamps
    end
  end
  
  def down
    drop_table :statuses
  end

end
