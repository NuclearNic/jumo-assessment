# == Schema Information
#
# Table name: loans
#
#  id           :integer          not null, primary key
#  msisdn       :string
#  network_id   :integer
#  date         :datetime
#  product_id   :integer
#  amount       :decimal(10, 2)
#  loan_file_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class LoanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
