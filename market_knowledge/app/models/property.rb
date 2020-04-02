class Property < ApplicationRecord
    has_many :leases, :dependent => :destroy
    validates :property_name, :street, :city, presence: true

  # Generate a CSV File of All Property Records
  def self.to_csv(fields = column_names, options={})
    CSV.generate(options) do |csv|      
            csv << fields
            all.each do |property|
                csv << property.attributes.values_at(*fields)
            end
        end
    end

  # Import CSV, Find or Create Property by its property_name.
  # Update the record.
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      property_hash = row.to_hash
      binding.pry
      @property = Property.where(:property_name => property_hash["property_name"], :street => property_hash["street"], :city => property_hash["city"]).first_or_create do |property|
        property.year_built = property_hash["year_built"]
        property.remodel_year = property_hash["remodel_year"]
        property.gross_bldg_area = property_hash["gross_bldg_area"]
        property.foundation_area = property_hash["foundation_area"]
        property.num_stories = property_hash["num_stories"]
        property.net_lease_area = property_hash["net_lease_area"]
        property.bldg_class = property_hash["bldg_class"]
        property.business_park = property_hash["business_park"]
        property.submarket = property_hash["submarket"]
        property.landlord_broker_company = property_hash["landlord_broker_company"]
        property.bldg_owner = property_hash["bldg_owner"]
        property.property_manager = property_hash["property_manager"]
        property.quoted_rate = property_hash["quoted_rate"]
        property.nnn = property_hash["nnn"]
        property.electric = property_hash["electric"]
      end
    end
  end

  def self.search(search)
    if search
      if search != ""
        #would like to build to accept partial matches "contains"
        @properties = Property.where(property_name: search)
      else
        @properties = Property.all
      end
    else
      @properties = Property.all
    end
  end

  def self.filter(filter)
    type = filter.keys[0]
    value = filter[type]
    case type
      when ""
        @properties = Property.all
      when "submarket"
        @properties = Property.where(submarket: value)
      else
        @properties = Property.all
    end
  end

end