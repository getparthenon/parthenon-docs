---
title: "Normaliser"
date: 2020-08-25T20:18:31+02:00
draft: false
sidebar_position: 3
---
Part of exporting data is normalising the data that is stored within the application's model to the format that is needed for the export. To handle this task we've created the normaliser.


## Creating a Normaliser

To create your own normaliser you must create a class that implements the `Parthenon\Export\Normaliser\NormaliserInterface`.

### Example

```php
<?php

namespace App\Export\Normaliser;

class EntityNormaliser implements \Parthenon\Export\Normaliser\NormaliserInterface {

      public function supports(mixed $item): bool {
        return $item instanceof \App\Entity\Example;
      }

      public function normalise(mixed $item): array {
        return [
          "name" => $item->getName(),
          "created_at" => $item->getCreatedAt(),
        ];
      }
}
```
