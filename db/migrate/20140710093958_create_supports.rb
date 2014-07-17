class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
      t.string :login, default: ''
      t.string :password
      t.string :first_name, default: ''
      t.string :last_name, default: ''
      t.string :email, default: ''
      t.references :role_id, index: true
      t.references :ticket, index: true

      t.timestamps
    end
  end
end
