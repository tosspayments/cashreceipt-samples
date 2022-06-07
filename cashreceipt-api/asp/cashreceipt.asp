<%@ Language="VBScript" CODEPAGE="65001"%>


<!DOCTYPE html>

<!--#include file="json2.asp"--> 
<!--#include file="base64.asp"--> 

<%
	
call initCodecs

timestamp = right("0" & hour(now),2) &  right("0" & minute(now),2) &  right("0" & second(now),2)

orderId = "cashreceipt-" & timestamp
amount	= 50000 
registrationNumber = "01000001234"
types = "소득공제"
taxFreeAmount = 0
orderName = "토스 티셔츠 외 2건"



secretkey = "test_ak_ZORzdMaqN3wQd5k6ygr5AkYXQGwy:"

url = "https://api.tosspayments.com/v1/cash-receipts"

data = "{""orderId"" : """ & orderId & """, ""amount"" : " & amount & "," &_
    """registrationNumber"" : """ & registrationNumber & """, ""type"" : """ & types & """," &_
    """taxFreeAmount"" : """ & taxFreeAmount & """, ""orderName"" : """ & orderName & """}"


authorization = "Basic " & base64Encode(secretkey)

set req = Server.CreateObject("MSXML2.ServerXMLHTTP")
req.open "POST", url, false
req.setRequestHeader "Authorization", authorization
req.setRequestHeader "Content-Type", "application/json;charset=UTF-8"
req.send data


set myJSON = JSON.parse(req.responseText)

httpCode = req.status

%>


<html lang="ko">
<head>
    <title>결제 성공</title>
    <meta charset="UTF-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
</head>
<body>
<section>
    <%
        if httpCode=200  then %>
        <h1>결제 성공</h1>
        <p>결과 데이터 : <%= req.responseText %></p>
        <p>orderName : <%= myJSON.orderName%></p>
        <p>receiptKey : <%= myJSON.receiptKey%></p>
        <p>approvalNumber :  <%= myJSON.approvalNumber%></p>
        <p>receiptUrl :  <%= myJSON.receiptUrl%></p>
       <%
     else  %>
        <h1>결제 실패</h1>
        <p>에러메시지 :  <%= myJSON.message%></p>
        <span>에러코드:  <%= myJSON.code%></span>
       <%
    end if
    %>

</section>
</body>
</html>
