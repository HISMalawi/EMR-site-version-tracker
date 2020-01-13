class CreatePersonNames < ActiveRecord::Migration[5.2]
  def change
    create_table :person_name, :primary_key => :person_name_id do |t|
      t.bigint    :person_id, null: false
      t.string    :first_name, null: false
      t.string    :last_name, null: false
      t.boolean   :active, null: false, default: 1

      t.timestamps
    end
  end

  def down
    drop_table  :person_name
  end
end
