class Lease < ApplicationRecord
    belongs_to :property

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
end