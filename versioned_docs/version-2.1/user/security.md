---
title: "User - Security"
date: 2020-08-25T20:19:24+02:00
draft: false
---
There may be times when you want to decide if a user is able to login or not based on customer rules. To enable this we use the Symfony User Checker functionality and extended it allowing multiple rules to be applied separate of each other.

## Add to Symfony Security

To add this to your symfony application you need to modify your `security.yaml`

```
security:
  firewalls:
      // ...
      main:
        // ...
        user_checker: Parthenon\User\Security\UserChecker\UserCheckerObserver
```

### Add a rule

With our extension to the user checker functionality you just create another implementation of a user checker and then add tag `parthenon.user.security.user_checker`.

An example is our if user has confirmed their email checker.

```php
<?php

declare(strict_types=1);

/*
 * Copyright Iain Cambridge 2020-2021, all rights reserved.
 */

namespace Parthenon\User\Security\UserChecker;

use Symfony\Component\Security\Core\Exception\CustomUserMessageAccountStatusException;
use Symfony\Component\Security\Core\User\UserCheckerInterface;
use Symfony\Component\Security\Core\User\UserInterface;

class ConfirmedUserChecker implements UserCheckerInterface
{
    public function checkPreAuth(UserInterface $user)
    {
    }

    public function checkPostAuth(UserInterface $user)
    {
        if (!$user instanceof \Parthenon\User\Entity\UserInterface) {
            return;
        }

        if (!$user->isConfirmed()) {
            throw new CustomUserMessageAccountStatusException('You need to confirm your account');
        }
    }
}
```

### Team Owned

When you're dealing with a multi-tenant system where they share a database you want to ensure that the user viewing the object has permission. When dealing with teams you need to make sure they're part of that team. To make this easy we added `Parthenon\User\Entity\TeamOwnedInterface`.

Easy to use:

```php
use Parthenon\User\Entity\TeamOwnedInterface;
use Parthenon\User\Entity\TeamInterface;

class Entity implements TeamOwnedInterface
{

    /**
     * @ORM\ManyToOne(targetEntity="Parthenon\User\Entity\TeamInterface")
     */
    private TeamInterface $team;

    // ...

    public function getOwningTeam(): TeamInterface
    {
        return $this->team;
    }
}
```

The reason for `getOwningTeam` and not `getTeam` is to deal with the possible issue that multiple teams can interact with an entity. For example, you have a worker platform where one person creates a project and others bid. It's possible both sides are teams.

To check if the user has permission as the owner.

```php
public function method(AuthorizationCheckerInterface $authorizationChecker)
{
  if (!$authorizationChecker->isGranted('view', $entity)) {
    return new JsonResponse(['success' => false], JsonResponse::HTTP_NOT_FOUND);
  }
}
```
