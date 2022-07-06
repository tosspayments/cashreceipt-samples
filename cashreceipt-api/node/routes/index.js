var express = require("express");
var got = require("got");
var uuid = require("uuid").v4;

var router = express.Router();

var secretKey = "test_ak_ZORzdMaqN3wQd5k6ygr5AkYXQGwy";

router.get("/cashreceipt", function (req, res) {
  let orderId = "cashreceipt-" + uuid();
  let amount = 50000;
  let registrationNumber = "01000001234";
  let type = "소득공제";
  let taxFreeAmount = 0;
  let orderName = "토스 티셔츠 외 2건";

  got
    .post("https://api.tosspayments.com/v1/payments/cash-receipts", {
      headers: {
        Authorization:
          "Basic " + Buffer.from(secretKey + ":").toString("base64"),
        "Content-Type": "application/json",
      },
      json: {
        orderId: orderId,
        amount: amount,
        registrationNumber: registrationNumber,
        type: type,
        taxFreeAmount: taxFreeAmount,
        orderName: orderName,
      },
      responseType: "json",
    })
    .then(function (response) {
      res.render("cashreceipt", {
        isSuccess: true,
        responseJson: response.body,
      });
    })
    .catch(function (error) {
      res.render("cashreceipt", {
        isSuccess: false,
        rresponseJson: error.response.body,
      });
    });
});

router.get("/cancelcashreceipt", function (req, res) {
  let receiptKey = "";

  got
    .post(
      "https://api.tosspayments.com/v1/payments/cash-receipts" +
        receiptKey +
        "/cancel",
      {
        headers: {
          Authorization:
            "Basic " + Buffer.from(secretKey + ":").toString("base64"),
          "Content-Type": "application/json",
        },
        responseType: "json",
      }
    )
    .then(function (response) {
      res.render("cancelcashreceipt", {
        isSuccess: true,
        responseJson: response.body,
      });
    })
    .catch(function (error) {
      res.render("cancelcashreceipt", {
        isSuccess: false,
        rresponseJson: error.response.body,
      });
    });
});

module.exports = router;
