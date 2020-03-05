class Property < ApplicationRecord
    has_many :leases
    # , :dependent => :destroy

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
      properties_hash = row.to_hash
      property = find_or_create_by!(property_name: properties_hash['property_name'])
      property.update_attributes(properties_hash)
    end
  end

  def self.search(search)
    if search
      if search != ""
        @properties = Property.where(property_name: search)
      else
        @properties = Property.all
      end
    else
      @properties = Property.all
    end
  end

end