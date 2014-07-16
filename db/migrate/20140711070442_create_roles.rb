class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :description
      t.references :support, index: true

      t.timestamps
    end
  end
end
