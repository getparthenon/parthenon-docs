---
title: "User - Timezone Aware"
date: 2020-08-25T20:19:24+02:00
draft: false
sidebar_label: "Timezone Aware"
---
When building an application it's often important that you're able to display times and dates in the timezone for the User. It's confusing when you're based in New York but see the times based in UTC or Berlin. Parthenon comes with a Timezone Aware ability where you're able to make the timezone based on either the User or the Team.

This is done by applying the `Parthenon\User\Entity\TimezoneAwareInterface` interface to either a user or a team entity class.

```php
use Parthenon\User\Entity\TimezoneAwareInterface;
use Parthenon\User\Entity\Team as BaseTeam;

class Team  extends BaseTeam implements TimezoneAwareInterface {
            public function getTimezone(): \DateTimeZone
            {
                return new \DateTimeZone('Europe/Berlin');
            }

            public function hasTimezone(): bool
            {
                return true;
            }
        };
```
