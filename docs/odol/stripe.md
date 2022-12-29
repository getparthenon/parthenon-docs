---
title: "Odol - Stripe"
sidebar_label: "Stripe"
date: 2020-09-04T17:30:32+02:00
draft: false
sidebar_position: 3
---
parameters


| name | required | type | description |
| ---     |  ---   |  ---  |  ---  |
| api_key | yes | string | The private API key for Stripe |
| success_url | no | string | The success url for hosted checkout. It is required if you're using hosted checkout. |
| pci_mode | no | boolean | If your implementation has a PCI security check and can collect card information. Otherwise stripe.js tokens must be used |
| cancel_url | no | string | the cancel url for the hosted checkout. It is required if you're using hosted checkout . |
