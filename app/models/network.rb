class Network < ApplicationRecord

	validates_uniqueness_of :name

	has_many :loans

end
