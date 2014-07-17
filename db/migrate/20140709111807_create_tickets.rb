class CreateTickets < ActiveRecord::Migration
  def up
    create_table :tickets do |t|
      t.integer :customer_id
      t.string :uuid, index: true
      t.datetime :created_at, default: Time.new
      t.references :owner_id, index: true
      t.references :status_id, index: true
      t.string :username, default: ''
      t.string :email, default: ''
      t.string :subject, default: ''
      t.text :problem, default: ''

      t.timestamps
    end
  end
end

