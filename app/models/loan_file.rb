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

		CSV.foreach(open(LoanFile.first.file.path), :headers => true, :col_sep => ',') do |row|
		
 			date = Date.parse(row['Date'].gsub(/'/,""))
			network = Network.find_or_create_by(name: row['Network'])	
			product = Product.find_or_create_by(name: row['Product'])	
			Loan.create(msisdn: row['MSISDN'], amount: row['Amount'], network_id: network.id, product_id: product.id, loan_file_id: self.id, date: date)

		end


	end


end
