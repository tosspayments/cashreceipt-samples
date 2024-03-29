from django.shortcuts import render

import requests, json, base64, time

# Create your views here.
def index(request):
  return render(
    request,
    'apis/index.html',
  )

def cashreceipt(request):
  datetime = int(time.time())

  url = "https://api.tosspayments.com/v1/cash-receipts"
  secertkey = "test_sk_D4yKeq5bgrpKRd0JYbLVGX0lzW6Y"
  userpass = secertkey + ':'
  encoded_u = base64.b64encode(userpass.encode()).decode()
  
  headers = {
    "Authorization" : "Basic %s" % encoded_u,
    "Content-Type": "application/json"
  }
        
  params = {
    "orderId": datetime,
    "amount": 50000,
    "registrationNumber": "01000001234",
    "type": "소득공제",
    "taxFreeAmount": 0,
    "orderName": "토스 티셔츠 외 2건",
  }
  
  res = requests.post(url, data=json.dumps(params), headers=headers)
  resjson = res.json()
  pretty = json.dumps(resjson, indent=4, ensure_ascii=False)

  return render(
    request,
    'apis/cashreceipt.html',
    {
      "res" : pretty,
    }
  )

def cancelcashreceipt(request):
  receiptKey = "o71DG90nOlP24xLea5zVAaOmo1dOYVQAMYNwW6BvjZdyEmJk"

  url = "https://api.tosspayments.com/v1/cash-receipts/"
  secertkey = "test_sk_D4yKeq5bgrpKRd0JYbLVGX0lzW6Y"
  userpass = secertkey + ':'
  encoded_u = base64.b64encode(userpass.encode()).decode()
  
  headers = {
    "Authorization" : "Basic %s" % encoded_u,
    "Content-Type": "application/json"
  }
  
  res = requests.post(url+receiptKey+"/cancel" , headers=headers)
  resjson = res.json()
  pretty = json.dumps(resjson, indent=4, ensure_ascii=False)


  return render(
    request,
    'apis/cancelcashreceipt.html',
    {
      "res" : pretty,
    }
  )