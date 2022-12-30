---
title: "Payments - Parameters"
date: 2020-08-25T18:51:52+02:00
draft: false
sidebar_label: "Parameters"
---
::: note
In 2.2 this has been deprecated for the Billing system.
:::

The parameters that are set in the container for the Parthenon payment module are as follows.

| parameter_name | description |
| --- | --- |
| parthenon_payments_stripe_private_api_key | The API key that Stripe provides for server side calls, it is called the private api key by Stripe. |
| parthenon_payments_stripe_public_api_key | The API key that Stripe provides for the javascript api, it is called the public api key by Stripe. |
| parthenon_payments_stripe_success_url | The URL to be provided to the Stripe Checkout that is to be used for Stripe to redirect to upon success. |
| parthenon_payments_stripe_cancel_url | The URL to be provided to the Stripe Checkout that is to be used when the user wants to cancel the checkout. |
| parthenon_payments_stripe_return_url | The URL to be provided to the Stripe Checkout that is to be used when the user wants to return to the application. |
| parthenon_payments_prices | The stripe prices |
| parthenon_payments_success_redirect_route | The route that is to be redirected to once they've returned to the application. This is used when the user has been redirected to the application's success endpoint by Stripe and then the application redirects them to this route. |
| parthenon_payments_cancel_checkout_redirect_route | The route that is to be redirected to once they've returned to the application. This is used when the user has been redirected to the application's cancel endpoint by Stripe and then the application redirects them to this route. |
