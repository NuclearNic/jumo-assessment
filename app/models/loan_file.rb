# == Schema Information
#
# Table name: loan_files
#
#  id         :integer          not null, primary key
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LoanFile < ApplicationRecord

	mount_uploader :file, LoanFileUploader
	has_many :loans



	# TODO: Prevent multiple upload of the same file
	def create_loans_from_file

		# TODO: Find or create network and product per row
		CSV.foreach(open(LoanFile.first.file.path), :headers => true, :col_sep => ',') do |row|
			Loan.create(msisdn: row['MSISDN'], amount: row['Amount'])
		end


	end


end
