class CreateShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :shifts do |t|
      t.integer :user_id
      t.datetime :start, null: false
      t.datetime :finish, null: false
      t.integer :break_length, null: false
      t.timestamps
    end
  end
end
