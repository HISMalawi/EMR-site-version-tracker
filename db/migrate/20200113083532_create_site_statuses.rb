class CreateSiteStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :site_statuses, :primary_key => :site_status_id do |t|
      t.date        :date_updated, null: false
      t.bigint      :location_id, null: false
      t.string      :app_name, null: false
      t.boolean     :voided, null: false, default: 0
      t.bigint      :user_id, null: false

      t.timestamps
    end
  end

  def down
    drop_table  :site_statuses
  end

end
