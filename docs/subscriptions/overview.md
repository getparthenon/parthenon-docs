---
title: "Subscriptions - Overview"
date: 2020-08-25T18:51:52+02:00
draft: false
sidebar_label: "Overview"
---
Parthenon comes with a Subscription system. This has a Plan system that allows you to provide a group of limits to a user.

## Configuration

| Name | Type | Description |
| --- | --- | --- |
| enabled | Boolean | To define if the plan module is enabled. |
| subscriber_type | string | The kind of subscriber team or user |
| plan | array | The plans |

### Plans

The plans are defined with the name of the plan and then it has the field limit that holds the limits for the plan.

The limits is defined by the name of the limit and the and limit as a number and the description.

| Name | Type | Description |
| --- | --- | --- |
| is_free | Boolean | If the plan is a free plan. |
| is_per_seat | Boolean | If the plan is charged as a per seat |
| features | array | The name of features for a plan. |
| limit | array | The limits for the plan. |
| user_count | integer | The number of users that plan has if is_per_seat is false |

```yaml
parthenon:
  subscriptions:
    enabled: true
    plan:
      basic:
        user_count: 1
        is_free: false # Default false
        is_per_seat: false # Default false
        features:
          - feature_one
        limit:
          limit_name:
            limit: 1
            description: "Description of limit"
      standard:
        user_count: 5
        features:
          - feature_one
          - feature_two
        limit:
          limit_name:
            limit: 5
            description: "Description of limit"
```

## Counter

One of the parts of ensuring a limit is enforced is knowing how many the user currently has. To handle this we created the `CounterInterface`

### Interface

The interface has two methods.

* `supports` - This method defines if this limitable item is supported by this counter. It returns a boolean value.
* `getCount` - This returns the count. If you want to make the it unlimited for a plan you can return `-1`.

```PHP
<?php

declare(strict_types=1);

/*
 * Copyright Humbly Arrogant Ltd 2020-2021, all rights reserved.
 */

namespace Parthenon\Subscriptions\Plan;

interface CounterInterface
{
    public function supports(LimitableInterface $limitable): bool;

    public function getCount(LimitedUserInterface $user, LimitableInterface $limitable): int;
}
```

### Example

Here is the example

```PHP
<?php

declare(strict_types=1);

/*
 * Copyright Humbly Arrogant Ltd 2020-2021, all rights reserved.
 */

namespace Parthenon\Subscriptions\Plan\Counter;

use Parthenon\Common\Exception\GeneralException;
use Parthenon\Subscriptions\Plan\CounterInterface;
use Parthenon\Subscriptions\Plan\LimitableInterface;
use Parthenon\Subscriptions\Plan\LimitedUserInterface;
use Parthenon\User\Entity\MemberInterface;
use Parthenon\User\Entity\TeamInviteCode;
use Parthenon\User\Repository\TeamInviteCodeRepositoryInterface;
use Parthenon\User\Repository\TeamRepositoryInterface;
use Parthenon\User\Repository\UserRepositoryInterface;

class TeamInviteCounter implements CounterInterface
{
    public function __construct(
        private TeamInviteCodeRepositoryInterface $inviteCodeRepository,
        private UserRepositoryInterface $userRepository,
        private TeamRepositoryInterface $teamRepository
    ) {
    }

    public function supports(LimitableInterface $limitable): bool
    {
        return $limitable instanceof TeamInviteCode;
    }

    public function getCount(LimitedUserInterface $user, LimitableInterface $limitable): int
    {
        if (!$user instanceof MemberInterface) {
            throw new GeneralException('User does not implement MemberInterface');
        }

        $team = $this->teamRepository->getByMember($user);

        $inviteCount = $this->inviteCodeRepository->getUsableInviteCount($team);
        $activeMemberCount = $this->userRepository->getCountForActiveTeamMemebers($team);

        return $inviteCount + $activeMemberCount;
    }
}

```

## Check if feature is enabled

To check if a feature is enabled for a user you can do the following.

```php
use Parthenon\Subscriptions\Plan\Plan;

/** @var \Symfony\Component\Security\Core\Authorization\AuthorizationCheckerInterface $authorizationChecker */
if (!$authorizationChecker->isGranted(Plan::CHECK_FEATURE, 'feature_name')) {
    throw new GeneralException("Not allowed to do this");
}
```

## Check Limit

To check if a user is allowed to do something we extend the Symfony AuthorizationChecker.

There are two supported attributed

* create
* enable

### Example

```php

/** @var \Symfony\Component\Security\Core\Authorization\AuthorizationCheckerInterface $authorizationChecker */
if (!$authorizationChecker->isGranted(TeamInviteCode::AUTH_CHECKER_ATTRIBUTE, $inviteCode)) {
    throw new GeneralException("Not allowed to do this");
}
```
