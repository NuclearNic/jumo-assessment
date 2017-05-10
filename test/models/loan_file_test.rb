# == Schema Information
#
# Table name: loan_files
#
#  id          :integer          not null, primary key
#  file        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  file_origin :integer
#  start_date  :date
#  end_date    :date
#

require 'test_helper'

class LoanFileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
