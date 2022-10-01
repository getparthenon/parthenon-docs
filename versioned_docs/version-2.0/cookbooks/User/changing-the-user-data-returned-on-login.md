---
title: "Changing the user data returned on login"
date: 2020-08-25T20:18:40+02:00
draft: false
---

Create a customer formatter class.

```php
<?php

namespace App\User;

use App\Entity\User as AppUser;
use Parthenon\User\Entity\User;
use Parthenon\User\Formatter\UserFormatterInterface;

class Formatter implements UserFormatterInterface
{
    /**
     * @param AppUser $user
     * @return array
     */
    public function format(User $user): array
    {
        return [
            'username' => $user->getUserIdentifier(),
            'roles' => $user->getRoles(),
            'plan' => $user->getTeam()?->getSubscription()?->getPlanName(),
        ];
    }
}
```

in the services.yaml

```
services:
  // ..

      Parthenon\User\Formatter\UserFormatterInterface: '@App\User\Formatter'
```
