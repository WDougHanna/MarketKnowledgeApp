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
# CSV must have the correct column names that match the schema
  def self.import(file)
    if file == nil

    else
      CSV.foreach(file.path, headers: true) do |row|
        lease_hash = row.to_hash 
        @property = Property.where(:property_name => lease_hash["property_name"])
        @property_id = @property[0][:id]
        lease_hash[:property_id] = @property_id
        lease_hash = lease_hash.except!("property_name")
        @lease = Lease.where(:tenant => lease_hash["tenant"], :lease_size => lease_hash["lease_size"], :property_id => lease_hash[:property_id]).first_or_create do |lease|
            lease.suite = lease_hash["suite"]
            lease.term = lease_hash["term"]
            lease.sign_date = lease_hash["sign_date"]
            lease.commencement_date = lease_hash["commencement_date"]
            lease.expiration_date = lease_hash["expiration_date"]
            lease.lease_type = lease_hash["lease_type"]
            lease.fy_rent = lease_hash["fy_rent"]
            lease.rent_type = lease_hash["rent_type"]
            lease.effective_rent = lease_hash["effective_rent"]
            lease.escalation = lease_hash["escalation"]
            lease.free_rent = lease_hash["free_rent"]
            lease.ti_psf = lease_hash["ti_psf"]
            lease.transaction_type = lease_hash["transaction_type"]
            lease.tenant_broker_company = lease_hash["tenant_broker_company"]
            lease.base_year = lease_hash["base_year"]
            lease.landlord_broker_company = @property[0][:landlord_broker_company]
            lease.bldg_owner = @property[0][:bldg_owner]
            lease.property_manager = @property[0][:property_manager]
            lease.quoted_rate = @property[0][:quoted_rate]
            lease.nnn = @property[0][:nnn]
            lease.electric = @property[0][:electric]
        end
     end
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
    # does not accept empty values for lease size
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