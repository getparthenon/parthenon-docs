---
title: "Athena - Export"
date: 2020-08-26T19:43:24+02:00
draft: false
---
There are many use cases for wanting to export data from Athena.

## Enabling in Settings

In the Section class there is a method `getSettings` which is overridable to define what parts of Athena are enabled.

By default export is enabled. To disable it you need to use the key `export` and give it a `false` value.

```PHP
<?php

namespace App\Athena;

use Parthenon\Athena\Settings;

class DemoSection extends AbstractSection
{
    public function getSettings(): Settings
    {
        return new Settings(['export' => false]);
    }
}
```
