class CreateUserRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_role do |t|
      t.bigint   :user_id, null: false
      t.bigint   :role_id, null: false
    end
  end

  def down
    drop_table :user_role
  end
end
