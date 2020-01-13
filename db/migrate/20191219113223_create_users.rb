class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, :primary_key => :user_id do |t|
      t.bigint    :person_id, null: false
      t.string    :email, null: false, uniq: true
      t.string    :password_digest, null: false
      t.datetime  :login_datetime
      t.datetime  :logout_datetime
      t.boolean   :active, null: false, default: 1

      t.timestamps
    end
  end

  def down
    drop_table :users
  end

end
