class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.decimal :hourly_rate, null: false

      t.timestamps
    end
    
  end
end
