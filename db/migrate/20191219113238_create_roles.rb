class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles, :primary_key => :role_id do |t|
      t.string    :role, null: false

      t.timestamps
    end
  end

  def down
    drop_table  :roles
  end
end
