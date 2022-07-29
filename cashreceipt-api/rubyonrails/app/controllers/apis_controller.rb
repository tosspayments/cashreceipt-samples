class PaymentController < ApplicationController

  def cashreceipt
    datetime = Time.now.to_i
    options = {
      headers: {
        Authorization: "Basic " + Base64.strict_encode64("test_sk_D4yKeq5bgrpKRd0JYbLVGX0lzW6Y:"),
        "Content-Type": "application/json"
      },
      body: {          
        orderId: "cashreceipt_#{datetime}",
        amount: 50000,
		    registrationNumber: "01000001234",
        type: "소득공제",
        taxFreeAmount: 0,
        orderName: "토스 티셔츠 외 2건"
      }.to_json
    }
      
	  begin
      response = HTTParty.post("https://api.tosspayments.com/v1/cash-receipts", options).parsed_response
      @Response = response
    end
      
  end
    
  def cancelcashreceipt
    receiptKey = ""
    options = {
      headers: {
        Authorization: "Basic " + Base64.strict_encode64("test_sk_D4yKeq5bgrpKRd0JYbLVGX0lzW6Y:"),
        "Content-Type": "application/json"
      }
    }
      
	  begin
      response = HTTParty.post("https://api.tosspayments.com/v1/cash-receipts/" + receiptKey + "/cancel", options).parsed_response
      @Response = response
    end
      
  end
  
end