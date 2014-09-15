class CreateTabs < ActiveRecord::Migration
  def change
    create_table :tabs do |t|
      t.string :name, default: ''
      t.text :states, default: ''

      t.timestamps
    end
  end
end
