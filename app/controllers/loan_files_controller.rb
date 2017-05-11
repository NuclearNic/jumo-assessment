class LoanFilesController < ApplicationController

  def create
    
      @loan_file = LoanFile.new(loan_file_params)

      if params[:loan_file][:file_origin] == 'generated'
        @loan_file.file = @loan_file.generate_loan_file
      end

    respond_to do |format|
      if @loan_file.save
      	@loan_file.create_loans_from_file unless @loan_file.generated?
        format.html { redirect_to loans_path,  :flash => { :success => 'File successfully uploaded' } }
      else
        @loan_file.errors.messages[:file_origin].present? ? message = 'File failed to upload: A file has already been uploaded with this date range.' : message = 'File failed to upload'
      	format.html { redirect_to loans_path, :flash => { :warning => message } }
      end
    end
  end

  private

    def loan_file_params
      params.require(:loan_file).permit(:file, :start_date, :end_date, :file_origin)
    end

end