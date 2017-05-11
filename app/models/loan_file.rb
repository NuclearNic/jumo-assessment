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

	validates :file_origin, uniqueness: { scope: [:start_date, :end_date] }
	validates_presence_of :file


  enum file_origin: [:uploaded, :generated]

	def create_loans_from_file

		if	Rails.env.production?
			CSV.parse(open(self.file_path).read(), headers:true).each do |row|
				network = Network.find_or_create_by(name: row['Network'])	
				product = Product.find_or_create_by(name: row['Product'])	
				Loan.create(msisdn: row['MSISDN'], amount: row['Amount'], network_id: network.id, product_id: product.id, loan_file_id: self.id, date: Date.parse(row['Date'].gsub(/'/,"")))
			end
		else
			CSV.foreach(open(self.file_path), :headers => true, :col_sep => ',') do |row|
				network = Network.find_or_create_by(name: row['Network'])	
				product = Product.find_or_create_by(name: row['Product'])	
				Loan.create(msisdn: row['MSISDN'], amount: row['Amount'], network_id: network.id, product_id: product.id, loan_file_id: self.id, date: Date.parse(row['Date'].gsub(/'/,"")))
			end
		end	
	end

	def generate_loan_file
		
		CSV.open("Output.csv", "wb") do |csv|

			csv << ['Network','Product','Month','Loan Count','Aggregate Amount']		
			loans = Loan.where('date BETWEEN ? AND ?', self.start_date, self.end_date)

			loans.group_by{|e| [e.network_id, e.product_id, e.date.beginning_of_month]}.each do |loans_for_month|
				l = loans_for_month[1]
				csv << [l[0].network.name,l[0].product.name,l[0].date.strftime("%B"), l.count ,l.map{|h| h.amount}.inject(:+)]
			end
			csv
		end
	end


	def file_path
		Rails.env.production? ? self.file.url : self.file.path
	end


end
