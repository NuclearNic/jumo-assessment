# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product < ApplicationRecord

	validates_uniqueness_of :name

	has_many :loans

end
