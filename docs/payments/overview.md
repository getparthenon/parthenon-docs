---
title: "Payments - Overview"
date: 2020-08-25T18:51:52+02:00
draft: false
sidebar_label: "Overview"
---
::: note
In 2.2 this has been deprecated for the Billing system.
:::

Parthenon comes with a Payment system that currently supports Stripe.

## Setup

Add the Parthenon to the symfony routing.

```yaml
parthenon_payments_controllers:
    prefix: /
    resource: ../../vendor/parthenon/parthenon/src/Payments/Controller/
    type: annotation
```

Setup the Parthenon configuration for payments.

| Name | Type | Description |
| --- | --- | --- |
| enabled | Boolean | To define if the payment module is enabled. |
| provider | string | What payment provider is to use. |
| stripe.private_api_key | String | The private Stripe API key. |
| stripe.public_api_key | String | The publishable Stripe API key. |
| stripe.success_url | string | The URL that the user should be sent to by Stripe when they've paid. |
| stripe.cancel_url | string | The URL that the user should be sent to when they cancel |
| success_redirect_route | string | The name of the symony route the user should be redirected to upon success |
| prices | array | The prices |

### Prices

Prices for plans are defined using an array that has the name of the plan and the payment schedule


```yaml
parthenon:
  payments:
  enabled: true
  provider: stripe
  subscriber_type: team
  stripe:
    private_api_key: '%env(resolve:STRIPE_PRIVATE_API_KEY)%'
    public_api_key: '%env(resolve:STRIPE_PUBLIC_API_KEY)%'
    success_url: "%env(resolve:APPLICATION_URL)%/api/payments/success/{CHECKOUT_SESSION_ID}"
    cancel_url: "%env(resolve:APPLICATION_URL)%/api/payments/cancel"
  prices:
    basic: # plan name
      monthly: stripe_price_id # payment schedule
      yearly: stripe_price_id
    standard:
      monthly: stripe_price_id
      yearly: stripe_price_id        
```


## Controllers

There are controller endpoints that will allow you to use stripe

####  GET /payments/plans/checkout/{planName}/{paymentSchedule}

Returns the checkout id that is to be used with the Stripe JS library to forward to a Stripe hosted checkout.

```javascript
{
  'id': 'id-given-by-stripe'
}
```

#### GET /payments/success/{checkoutId}

The endpoint to be hit when the user has successfully paid. This will mark the subscriber as paid.

#### POST /payments/plans/change/{planName}/{paymentSchedule}

```javascript
{
  'success': true,
  'plan': {
    'plan_name' 'plan name',
    'payment_schedule': 'monthly',
    'status': 'active'
  }
}
```

#### GET /payments/cancel

The controller that the user will be redirected to when they cancel from the checkout.
