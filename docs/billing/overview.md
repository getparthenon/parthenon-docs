---
title: "Billing - Overview"
sidebar_label: "Overview"
date: 2020-09-04T17:30:32+02:00
draft: false
sidebar_position: 1
---
The billing system is how you're able to bill customers.

## Payment Configs

| Name | Type | Description |
| --- | --- | --- |
| provider | string | What payment provider is to use. |
| pci_mode | boolean | If PCI mode is enabled where it's possible to sent card details directly to the payment gateway. |
| return_url | string | The return url to give to the payment gateway |
| cancel_url | string | The cancel url to give to the payment gateway |
| adyen | array | The adyen config |
| stripe | array | The Stripe Config |

### Adyen Configs

| Name | Type | Description |
| --- | --- | --- |
| api_key | string | The API key |
| merchant_account | string | The merchant account for Adyen. |
| test_mode | boolean | If you're using test servers for Adyen. For development mode. |
| prefix | string | The prefix Adyen has given you for production access. |

### Stripe Configs

| Name | Type | Description |
| --- | --- | --- |
| private_api_key | string | The private  API key |
| public_api_key | string | The public API key |
| payment_methods | array | The payment methods to be used for Stripe hosted checkout |

## PCI Mode

Processing card details yourself is a security risk and some payment providers demand you've passed PCI checks to even allow it.
