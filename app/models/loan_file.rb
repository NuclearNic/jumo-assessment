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

class LoanFile < ApplicationRecord

	require 'open-uri'
	mount_uploader :file, LoanFileUploader
	has_many :loans

	validates_presence_of :file

  enum file_origin: [:uploaded, :generated]


	# TODO: Prevent multiple upload of the same file
	def create_loans_from_file

		if	Rails.env.production?

			CSV.parse(open(self.file_path).read(), headers:true).each do |row|
				network = Network.find_or_create_by(name: row['Network'])	
				product = Product.find_or_create_by(name: row['Product'])	
				Loan.create(msisdn: row['MSISDN'], amount: row['Amount'], network_id: network.id, product_id: product.id, loan_file_id: self.id, date: Date.parse(row['Date'].gsub(/'/,"")))
			end
		
		else
			# f = CSV.parse(open(l.file_path).read, :headers => true, :col_sep => ',')
			CSV.foreach(open(self.file_path), :headers => true, :col_sep => ',') do |row|
				network = Network.find_or_create_by(name: row['Network'])	
				product = Product.find_or_create_by(name: row['Product'])	
				Loan.create(msisdn: row['MSISDN'], amount: row['Amount'], network_id: network.id, product_id: product.id, loan_file_id: self.id, date: Date.parse(row['Date'].gsub(/'/,"")))
			end
		end	
	end

	def generate_loan_file
		
		# CSV.open("public/tmp/Output.csv", "wb") do |csv|
		CSV.open("Open.csv", "wb") do |csv|

			csv << ['Network','Product','Month','Amount']		
			loans = Loan.where('date BETWEEN ? AND ?', self.start_date, self.end_date)

			loans.group_by{|e| [e.network_id, e.product_id, e.date.beginning_of_month]}.each do |loans_for_month|
				l = loans_for_month[1][0]
				csv << [l.network.name,l.product.name,l.date.strftime("%B"),loans_for_month[1].map{|h| h.amount}.inject(:+)]
			end
			csv
		end
	end


	def file_path
		Rails.env.production? ? self.file.url : self.file.path
	end


end
