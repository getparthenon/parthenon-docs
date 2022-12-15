---
title: "Athena - Export"
sidebar_label: "Export"
date: 2020-08-26T19:43:24+02:00
draft: false
---
There are many use cases for wanting to export data from Athena.

## Defining the data to be exported

To define the export data you need to define a `Normaliser`. A normaliser is what converts the entity raw data to the data that is to be returned in the export file.

```php
<?php

namespace App\Athena;

use Parthenon\Athena\AbstractSection;
use Parthenon\Athena\Settings;

class DemoSection extends AbstractSection
{

    public function buildNormalsier(NormaliserBuilderInterface $builder): NormaliserBuilderInterface
    {
        $builder->addField('id', 'id')
            ->addField('name', 'customer_name');
            ->addField('jsonArray', 'extra_data', function ($value) { return json_encode($value); });


        return $builder;
    }
}
```

:::note

By default the normaliser will return all the data in the entity.

:::

## Enabling in Settings

In the Section class there is a method `getSettings` which is overridable to define what parts of Athena are enabled.

By default export is enabled. To disable it you need to use the key `export` and give it a `false` value.

```PHP
<?php

namespace App\Athena;

use Parthenon\Athena\AbstractSection;
use Parthenon\Athena\Settings;

class DemoSection extends AbstractSection
{
    public function getSettings(): Settings
    {
        return new Settings(['export' => false]);
    }
}
```

## Limiting to a user roles

You may not want to allow all users to export data. By using the access rights functionality within Athena you can limit who can export data for each section.

You return an array with the key `export` that has a string value of the role that is allowed to use the export functionality.

```php
<?php

namespace App\Athena;

use Parthenon\Athena\AbstractSection;

class DemoSection extends AbstractSection
{
    public function getAccessRights(): array
    {
        return ['export' => 'ROLE_DATA_ANALYST'];
    }
}
```
