class AddStatusToDevices < ActiveRecord::Migration[5.0]
  def change
    add_column :devices, :status, :integer, default: 0
  end
end
