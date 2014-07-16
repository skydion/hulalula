class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.text :body
      t.integer :owner_id
      t.datetime :created_at, default: Time.now
      t.references :ticket, index: true

      t.timestamps
    end
  end
end
