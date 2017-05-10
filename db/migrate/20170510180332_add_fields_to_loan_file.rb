class AddFieldsToLoanFile < ActiveRecord::Migration[5.0]
  def change
    add_column :loan_files, :file_origin, :integer
    add_column :loan_files, :start_date, :date
    add_column :loan_files, :end_date, :date
  end
end
