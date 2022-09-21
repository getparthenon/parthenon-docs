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

### setInvoiceNumber

Set the invoice number.

### addVatToTotal

Sometimes you want to add the VAT to the total. Calling this method will make that happen once the invoice is built.

### deductVatFromTotal

Sometimes you don't want to add the VAT to the total. Calling this method will make that happen once the invoice is built.

### addVatNumber

This takes a string that contains the VAT number.

### setBillerAddress

This accepts an instance of `Parthenon\Common\Address`

### setCountryRules

This accepts an instance of `Parthenon\Invoice\CountryRules`

### setCurrency

This accepts an string that sets the currency.

### setDeliveryAddress

This accepts an instance of `Parthenon\Common\Address`

### setPaymentDetails

This accepts an string that contains the payment details

### setCreatedAt

This accepts an instance of `DateTimeInterface`.

### build

This method will build the invoice with all the information given to the InvoiceBuilder and will return an `Parthenon\Invoice\Invoice` instance.
