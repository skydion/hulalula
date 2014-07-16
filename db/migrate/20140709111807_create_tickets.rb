class CreateTickets < ActiveRecord::Migration
  def up
    create_table :tickets do |t|
      t.integer :customer_id
      t.string :uuid
      t.datetime :created_at, default: Time.new
      t.integer :owner_id
      t.integer :status_id
      t.string :username
      t.string :email
      t.string :subject
      t.text :problem

      t.timestamps
    end
  end
end

