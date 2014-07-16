class CreateTicketStates < ActiveRecord::Migration
  def change
    create_table :ticket_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
