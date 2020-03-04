class Property < ApplicationRecord
    has_many :leases
    # , :dependent => :destroy
end