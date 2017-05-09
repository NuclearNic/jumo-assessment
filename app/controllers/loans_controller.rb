class LoansController < ApplicationController


  def index
  	
  end


  private

    def loan_params
      params.require(:loan).permit(:msisdn, :date, :amount, :file)
    end

end