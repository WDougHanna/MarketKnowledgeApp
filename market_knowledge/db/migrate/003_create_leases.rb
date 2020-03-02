class CreateLeases < ActiveRecord::Migration[5.2]
    def change
      create_table :leases do |t|
        t.string :tenant

        t.string :bldg_name
       
        t.integer :lease_size
        t.string :suite
        t.integer :term

        t.date :sign_date
        t.date :expiration_date

        t.string :lease_type
        t.integer :fy_rent
        t.string :rent_type
        t.integer :effective_rent
        t.string :escalation
        t.intger :free_rent
        t.integer :ti_psf
        t.string :transaction_type
        t.string :contact

        t.string :base_year

        t.timestamps
      end
    end
  end