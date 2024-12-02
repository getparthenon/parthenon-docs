---
title: "Billing - BillaBear"
sidebar_label: "BillaBear"
date: 2020-09-04T17:30:32+02:00
draft: false
sidebar_position: 3
---
BillaBear is a standalone billing system designed to replace Stripe Billing/ChargeBee/etc.

```yaml
parthenon:
  billing:
    enabled: true
    billabear:
      enabled: true
      api_key: '%env(resolve:BILLABEAR_API_KEY)%'
      api_url: '%env(resolve:BILLABEAR_API_URL)%'
```