---
title: "Payments - Getting Started"
date: 2020-08-25T18:51:52+02:00
draft: false
sidebar_label: "Getting Started"
---
To get started using the Payment System.

Steps:

1. Sign Up For Stripe
2. Configure Payment Module
3. Configure Prices

## 1. Sign Up For Stripe

The first step is to sign up for Stripe.

## 2. Configure Payment Module

Once you have a Stripe account and have API keys. You need to configure the payment module.

### 2.1 Configuration

You can need add the configuration that enables the payment module.

```yaml
parthenon:
  // ...
  payments:
    enabled: true # If not true the payment module will not be enabled
    provider: stripe
    success_redirect_route: app_plan
    cancel_checkout_redirect_route: app_plan
    stripe:
      private_api_key: '%env(resolve:STRIPE_PRIVATE_API_KEY)%'
      public_api_key: '%env(resolve:STRIPE_PUBLIC_API_KEY)%'
      success_url: "%env(resolve:APPLICATION_URL)%/api/payments/success/{CHECKOUT_SESSION_ID}"
      cancel_url: "%env(resolve:APPLICATION_URL)%/api/payments/checkout/cancel"
      return_url: '%env(resolve:APPLICATION_URL)%/app/plan'
```

### 2.2 Routes

Add the routes for the payment controllers.

```yaml
parthenon_payments_controllers:
    prefix: /api
    resource: ../vendor/parthenon/parthenon/src/Payments/Controller/
    type: annotation
```

## 3. Set Prices

The prices configuration is set as you have the price configuration and then a list where the key is the subscription name and it contains array where the key is the payment schedule and in that array is `price` and `price_id`.

The `price_id` is the ID provided by Stripe. The `price` is the display price.

```YAML
parthenon:
  // ...
  payments:
    // ...
    price:
      Basic:
        monthly:
          price: '20'
          price_id: '%env(resolve:BASIC_MONTHLY_PRICE_ID)%'
        yearly:
          price: '150'
          price_id: '%env(resolve:BASIC_YEARLY_PRICE_ID)%'
      Standard:
        monthly:
          price: '500'
          price_id: '%env(resolve:STANDARD_MONTHLY_PRICE_ID)%'
        yearly:
          price: '5000'
          price_id: '%env(resolve:STANDARD_YEARLY_PRICE_ID)%'
```
