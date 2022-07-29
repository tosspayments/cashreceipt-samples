Rails.application.routes.draw do
    # add code
  
    get 'apis/cashreceipt' => 'apis#cashreceipt'
    get 'apis/cancelcashreceipt' => 'apis#cancelcashreceipt'
    
    # end code
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
