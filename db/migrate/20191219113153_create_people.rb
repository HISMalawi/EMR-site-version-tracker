class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :person, :primary_key => :person_id do |t|
      t.string    :gender, null: false, limit: 1
      t.boolean   :active, null: false, default: 1

      t.timestamps
    end
  end

  def down
    drop_table  :person
  end
end
