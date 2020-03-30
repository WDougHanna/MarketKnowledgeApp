class Lease < ApplicationRecord
    belongs_to :property
    validates :property_id, :lease_size, presence: true

  # Generate a CSV File of All Lease Records
  def self.to_csv(fields = column_names, options={})
  CSV.generate(options) do |csv|      
          csv << fields
          all.each do |lease|
              csv << lease.attributes.values_at(*fields)
          end
      end
  end

# Import CSV, Find or Create Lease by its tenant.
# A tenant might have multiple leases which would cause an issue, look for a different field
# Update the record.
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      leases_hash = row.to_hash
      lease = find_or_create_by!(tenant: leases_hash['tenant'])
      lease.update_attributes(leases_hash)
    end
  end

  def self.search(search)
    if search
      if search != ""
        @leases = Lease.where(tenant: search)
      else
        @leases = Lease.all
      end
    else
      @leases = Lease.all
    end
  end

  def self.filter(parameters)
    inf = 1.0/0
    property_ids = []
    
    lease_low = parameters[:lease_low] == "" ?  0 : parameters[:lease_low]
    lease_high = parameters[:lease_high] == "" ? inf : parameters[:lease_high]
    lcd_low = parameters[:lcd_low] == "" ?  Date.iso8601("2000-01-01") : Date.iso8601(parameters[:lcd_low])
    lcd_high = parameters[:lcd_high] == "" ? Date.iso8601("2100-01-01") : Date.iso8601(parameters[:lcd_high])
    lxd_low = parameters[:lxd_low] == "" ?  Date.iso8601("2000-01-01") : Date.iso8601(parameters[:lxd_low])
    lxd_high = parameters[:lxd_high] == "" ? Date.iso8601("2100-01-01") : Date.iso8601(parameters[:lxd_high])
    
    @properties = Property.where(submarket: parameters[:submarket][:submarket])
    @properties.each do |property|
      property_ids << property.id
    end
    
    property_ids = property_ids == [] ? [0..100000] : property_ids #needs refactor
    
    @leases = Lease.where(property_id: property_ids, lease_size: lease_low..lease_high, commencement_date: lcd_low..lcd_high, expiration_date: lxd_low..lxd_high)
  end
  

end