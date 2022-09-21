---
title: "Invoice - Multi-Country VAT"
label: "Multi-Country VAT"
date: 2020-09-04T17:30:32+02:00
draft: false
---
Multi-Country VAT is important for companies operating in multiple countries. Parthenon allows for defining the country rules for VAT easily and quickly.

### BasicCountryTypeRule

Parthenon comes with a VAT Rule class that supports type and country. This means you can define the vat for a specific type of item and country. This becomes useful when a country has multiple VAT levels for different types of products.

```php
$rule = new \Parthenon\Invoice\Vat\BasicCountryTypeRule($country, $type, $percentage);
```

## VatRuleInterface

You can implement your own types of VatRules by implementing the `Parthenon\Invoice\Vat\VatRuleInterface`

```php
namespace Parthenon\Invoice\Vat;

use Parthenon\Common\Address;
use Parthenon\Invoice\ItemInterface;

interface VatRuleInterface
{
    /**
     * This method will return true or false on if the item is
     * and address are supported by this vat rule.
     *
     * @return bool
     */
    public function supports(ItemInterface $item, Address $address): bool;

    /**
     * This method modifies $item to add the vat rate that is
     * to be set based upon this rule.
     *
     * @return void
     */
    public function setVat(ItemInterface $item): void;
}
```
