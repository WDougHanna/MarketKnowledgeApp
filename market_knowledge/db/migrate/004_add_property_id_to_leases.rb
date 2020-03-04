class AddPropertyIdToLeases < ActiveRecord::Migration[5.2]
    def change
      add_column :leases, :property_id, :integer
    end
  end