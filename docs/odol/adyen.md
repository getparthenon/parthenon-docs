---
title: "Odol - Adyen"
sidebar_label: "Adyen"
date: 2020-09-04T17:30:32+02:00
draft: false
sidebar_position: 3
---
parameters


| name | required | type | description |
| ---     |  ---   |  ---  |  ---  |
| api_key | yes | string | The private API key for Adyen |
| merchant_account | yes | string | The merchant account for Adyen |
| pci_mode | no | boolean | If your implementation has a PCI security check and can collect card information. Otherwise adyen encrypted data must be used. Default is false. |
| test_mode | no | boolean | If you're in the test mode. Default is true. |
| return_url | no | string | The success url for hosted checkout. It is required if you're using hosted checkout. |
| prefix | no | string | The prefix for your production apis . |
