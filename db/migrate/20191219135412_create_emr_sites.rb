class CreateEmrSites < ActiveRecord::Migration[5.2]
  def change
    create_table :emr_site, :primary_key => :emr_site_id do |t|
      t.bigint    :emr_site_type_id, null: false
      t.string    :code
      t.bigint    :location_id, null: false

      t.timestamps
    end
  end

  def down
    drop_table :emr_site
  end
end
