class LoansController < ApplicationController


  def index
  	@loan_file = LoanFile.new
  end


  private

    def loan_params
      params.require(:loan).permit(:msisdn, :date, :amount, :file)
    end

end