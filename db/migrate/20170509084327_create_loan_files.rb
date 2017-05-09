class CreateLoanFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :loan_files do |t|
      t.string :file

      t.timestamps
    end
  end
end
