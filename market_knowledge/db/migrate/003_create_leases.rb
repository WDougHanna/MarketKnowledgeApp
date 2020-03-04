class CreateLeases < ActiveRecord::Migration[5.2]
    def change
      create_table :leases do |t|
        t.string :tenant

       #display bldg name, address, submarket, class

        t.integer :lease_size
        t.string :suite
        t.integer :term

        t.date :sign_date
        t.date :commencement_date
        t.date :expiration_date

        t.string :lease_type
        t.integer :fy_rent
        t.string :rent_type
        t.integer :effective_rent
        t.string :escalation
        t.intger :free_rent
        t.integer :ti_psf
        t.string :transaction_type
        t.string :tenant_broker_company

        t.string :base_year

        t.string :landlord_broker_company
        t.string :bldg_owner
        t.string :property_manager
        t.integer :quoted_rate
        t.integer :nnn
        t.integer :electric


        #display tenant, bldg name, term, commencement_date, fy_rent, rent_type, escalation, free_rent, ti_psf, lease_size


        t.timestamps
      end
    end
  end