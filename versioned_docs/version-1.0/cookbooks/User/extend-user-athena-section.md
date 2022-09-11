---
title: "Extend User Athena Section"
date: 2020-08-25T20:18:40+02:00
draft: false
---
Extending the User's Athena section is a very common task. Here is an example.

```php
<?php

namespace App\Athena;

use Parthenon\Athena\ReadView;

class UserSection extends \Parthenon\User\Athena\UserSection
{
    public function buildReadView(ReadView $readView): ReadView
    {
        $readView = parent::buildReadView($readView);

        $readView->section('Packagist')
            ->field('team.packagistCredentials.customerName', )
            ->field('team.packagistCredentials.token')
            ->end();

        return $readView;
    }
}
```