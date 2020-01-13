class CreateEmrSiteTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :emr_site_type, :primary_key => :emr_site_type_id do |t|
      t.string    :name, null: false

      t.timestamps
    end
  end

  def down
    drop_table  :emr_site_type
  end

end
