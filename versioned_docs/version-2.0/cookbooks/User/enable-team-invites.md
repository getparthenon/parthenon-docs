---
title: "Enable team invites"
date: 2020-08-25T20:18:40+02:00
draft: false
---
To enable team invites for a team plan you need to do the following.

## Entity

Create the team invite entity.

```php 
<?php

/*
 * Copyright Humbly Arrogant Ltd 2020-2022, all rights reserved.
 */

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use Parthenon\Plan\LimitableInterface;

/**
 * @ORM\Entity()
 * @ORM\Table(name="team_invite_codes")
 */
class TeamInviteCode extends \Parthenon\User\Entity\TeamInviteCode implements LimitableInterface
{
}
```

Create the Team entity.

:::warning

Due to how Doctrine works and it not allowing relations to Superclasses. The members needs to be declared in the sub class.

:::


```php
<?php

namespace App\Entity;

use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Parthenon\Payments\Entity\Subscription;
use Parthenon\Payments\Subscriber\SubscriberInterface;
use Parthenon\User\Entity\UserInterface;

/**
 * @ORM\Entity()
 * @ORM\Table(name="teams")
 */
class Team extends \Parthenon\User\Entity\Team implements SubscriberInterface
{
    /**
     * @ORM\OneToMany(targetEntity="App\Entity\User", mappedBy="team")
     *
     * @var UserInterface[]|Collection
     */
    protected Collection $members;

}

```

## Add EntityFactory

Update the entity factory so it uses the correct entity for Doctrine.

```php
<?php

namespace App\User\Entity;

use Parthenon\User\Entity\ForgotPasswordCode;
use Parthenon\User\Entity\InviteCode;
use Parthenon\User\Entity\TeamInterface;
use Parthenon\User\Entity\TeamInviteCode;
use Parthenon\User\Entity\UserInterface;
use Parthenon\User\Factory\EntityFactory as BaseFactory;

class EntityFactory extends BaseFactory
{
    // ...

    public function buildTeamInviteCode(UserInterface $user, TeamInterface $team, string $email, string $role): TeamInviteCode
    {
        return \App\Entity\TeamInviteCode::createForUserAndTeam($user, $team, $email, $role);
    }
}
```