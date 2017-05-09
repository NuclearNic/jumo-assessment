class LoanFilesController < ApplicationController

  def create
    @loan_file = LoanFile.new(loan_file_params)

    respond_to do |format|
      if @loan_file.save
      	@loan_file.create_loans_from_file
        format.html { redirect_to loans_path, notice: 'File uploaded.' }
      else
      	format.html { redirect_to loans_path, notice: 'File failed to upload' }
      end
    end
  end



  private

    def loan_file_params
      params.require(:loan_file).permit(:file)
    end

end