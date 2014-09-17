class AddShowToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :show, :boolean, default: true
  end
end
