class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
      t.string :login
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :role_id
      t.references :ticket, index: true

      t.timestamps
    end
  end
end
