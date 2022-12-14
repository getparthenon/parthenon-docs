---
title: "Invoice - Invoice Number Generator"
sidebar_label: "Invoice Number Generator"
date: 2020-09-04T17:30:32+02:00
draft: false
---
Often there is some business logic that is used to generate the invoice number. Some companies want to hide the number of invoices they're issuing. Some countries have laws regarding the invoice numbers. To help isolate and encapsulate the invoice number generation logic to a single place Parthenon has `Parthenon\Invoice\InvoiceNumberGeneratorInterface`.

```php
<?php

declare(strict_types=1);

/*
 * Copyright Iain Cambridge 2020-2022.
 *
 * Use of this software is governed by the Business Source License included in the LICENSE file and at https://getparthenon.com/docs/next/license.
 *
 * Change Date: TBD ( 3 years after 2.0.0 release )
 *
 * On the date above, in accordance with the Business Source License, use of this software will be governed by the open source license specified in the LICENSE file.
 */

namespace Parthenon\Invoice;

interface InvoiceNumberGeneratorInterface
{
    /**
     * @return mixed
     */
    public function generateNumber(?Invoice $invoice = null) : mixed;
}
```
