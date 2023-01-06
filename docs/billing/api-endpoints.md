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

### Request
```json
{
    "token": "token-we-got-from-the-payment-provider"
}
```

### Response

Status code **202**

Body

```json
{
  "success": true,
	"payment_details": {
		"id": "18756274-8a10-4c0a-ac01-663fcb911f74",
		"defaultPaymentOption": false,
		"brand": "Visa",
		"lastFour": "4242",
		"expiryMonth": "4",
		"expiryYear": "2023",
		"createdAt": "2023-01-05T11:08:27+00:00",
		"deleted": false
	}
}
```

## Fetch billing details

**Endpoint** `/billing/details`<br />
**Method** `GET`<br />

### Response

**Status Code** `200`

```json
{
	"address": {
		"company_name": null,
		"street_line_one": "Test",
		"street_line_two": null,
		"city": "test",
		"region": null,
		"country": "",
		"post_code": null
	}
}
```

## Update billing details

**Endpoint** `/billing/details`<br />
**Method** `POST`<br />

**Body**
```json
{
		"company_name": null,
		"street_line_one": "Test",
		"street_line_two": null,
		"city": "test",
		"region": null,
		"country": "",
		"post_code": null
}
```

### Response

#### Error

**Status Code** `400`

```json
{
  "success": false,
  "errors": {
    "country": [
      "error message one",
      "error message two"
    ]
  }
}
```

#### Success

**Status Code** `202`

```json
{
  "success": true
}
```
