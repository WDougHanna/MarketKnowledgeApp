class CreateProperties < ActiveRecord::Migration[5.2]
    def change
      create_table :properties do |t|
        t.string :property_name

        t.string :street
        t.string :city

        t.integer :year_built
        t.integer :remodel_year
        t.integer :gross_bldg_area
        t.integer :foundation_area
        t.integer :num_stories
        t.integer :net_lease_area

        t.string :bldg_class
        t.string :business_park
        t.string :submarket

        #save to lease when saving lease at that time

        t.string :landlord_broker_company
        t.string :bldg_owner
        t.string :property_manager
        t.integer :quoted_rate
        t.integer :nnn
        t.integer :electric

        t.timestamps
      end
    end
  end