---
title: "Invoice - Overview"
label: "Overview"
date: 2020-09-04T17:30:32+02:00
draft: false
---
Parthenon comes with an invoice generation ability.

## InvoiceBuilder

To build an invoice you use the `Parthenon\Invoice\InvoiceBuilder`.

### addItem

| Parameter | Type | Description |
| --- | --- | --- |
| `$name` | string | The name of the item |
| `$value` | `Brick\Money\Money` | The value of the item |
| `$options` | array | The options for the items. |

Options

| Name | Type | Description |
| --- | --- | --- |
| `quantity` | `integer` | The quantity of the items |
| `vat` | `float` | The VAT percentage |
| `type` | `string` | The type of item |
| `description` | `string` | The description for the item |
