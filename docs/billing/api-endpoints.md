---
title: "Billing - API Endpoints"
sidebar_label: "API Endpoints"
date: 2020-09-04T17:30:32+02:00
draft: false
sidebar_position: 2
---

## Fetch Payment details

**Endpoint** `/billing/payment-details`<br />
**Method** `GET`<br />

### Response

```json
{
	"payment_details": [{
		"id": "18756274-8a10-4c0a-ac01-663fcb911f74",
		"defaultPaymentOption": false,
		"brand": "Visa",
		"lastFour": "4242",
		"expiryMonth": "4",
		"expiryYear": "2023",
		"createdAt": "2023-01-05T11:08:27+00:00",
		"deleted": false
	}]
}
```

## Get card collection token for client side collection

**Endpoint** `/billing/card/token/start`<br />
**Token** `GET`<br />
**Providers** `Adyen`, `Stripe`<br />

### Response
```json
{
  "token": "token-here",
  "api_info": "api info here"
}
```

## Add card by token

**Endpoint** `/billing/card/token/add`<br />
**Method** `POST`<br />
**Providers** `Stripe`<br />

### Response
```json
{
    "token": "token-we-got-from-the-payment-provider"
}
```
