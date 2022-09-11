---
title: "Enable Athena Notifications"
date: 2020-08-25T20:18:40+02:00
draft: false
---
To enable Athena notifications you need to do the following:

If you're using Doctrine ORM.

```php
<?php

namespace App\Repository\Orm;

use Doctrine\Persistence\ManagerRegistry;
use Parthenon\Athena\Entity\Notification;
use Parthenon\Common\Repository\CustomServiceRepository;

class NotificationRepository extends CustomServiceRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Notification::class);
    }
}
```

And then

Add to your services.yaml
```yaml
Parthenon\Athena\Repository\NotificationRepositoryInterface: '@Parthenon\Athena\Repository\NotificationRepository'
Parthenon\Athena\Repository\NotificationRepository:
    class: Parthenon\Athena\Repository\NotificationRepository
    arguments:
        - '@App\Repository\Orm\NotificationRepository'
```
