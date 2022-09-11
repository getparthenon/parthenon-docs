---
title: "Enable plans"
date: 2020-08-25T20:18:40+02:00
draft: false
---
## Make user a limitable user

Implement the LimitedUserInterface

```php

use Parthenon\Plan\LimitedUserInterface;

class User extends \Parthenon\User\Entity\User implements LimitedUserInterface  
{
    // ...
    
    public function getPlanName(): string
    {
        return $this->getSubscription()?->getPlanName() ?? '';
    }
}
```

## Config

Add the plans config

```yaml
parthenon:
  plan:
    enabled: true
    plan:
      Basic:
        limit:
          team_invite:
            limit: 1
            description: "Number of users"
      Standard:
        limit:
          team_invite:
            limit: 5
            description: "Number of users"
```
