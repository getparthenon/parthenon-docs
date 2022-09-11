---
title: "Set Free Plan as default"
date: 2020-08-25T20:18:40+02:00
draft: false
---
How to see the free plan as default.

# User Event

```php
<?php

namespace App\User\Events;

use App\Entity\User;
use App\Repository\UserRepositoryInterface;
use Parthenon\Payments\Entity\Subscription;
use Parthenon\User\Event\PostUserSignupEvent;
use Parthenon\User\Event\PreUserSignupEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class UserSignup implements EventSubscriberInterface
{
    public function __construct(private UserRepositoryInterface $userRepository)
    {
        $this->userRepository = $userRepository;
    }

    public function handleUserSignUp(PostUserSignupEvent $postUserSignupEvent)
    {
        /** @var User $user */
        $user = $postUserSignupEvent->getUser();
        $user->getTeam()->setSubscription(new Subscription());
        $user->getTeam()->getSubscription()->setPlanName('free');
        $this->userRepository->save($user);
    }

    public static function getSubscribedEvents()
    {
        return [
            PostUserSignupEvent::NAME => 'handleUserSignUp',
        ];
    }
}
```
