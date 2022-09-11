---
title: "Subscription - Subscription Status"
date: 2020-08-25T18:51:52+02:00
draft: false
sidebar_label: "Subscription Status"
---
Keeping track of the subscription status is important. You want to be able to deactivate someone who hasn't paid, you want to be able to remind someone to pay who is late on a payment, and you want to reactivate people who were deactivated and are now active again. To do this Parthenon has a background command to run at scheduled time.

## Architectural decision

To keep track of the subscription status, Parthenon will poll the payment provider to see what the status of the payment is. While payment providers such as Stripe provide webhooks where they can send updates, when operating at scale these webhooks provide a point of failure. It's often experienced at larger scales that webhook requests fail. Thus we took the decision to fetch the data this way we're able to get the latest data and be aware that this is the latest data.

## Transtations

The point of the subscription status command is to be able to move a subscription from one state to another. To allow for this we've created interfaces that can be implemented that will automatically be detected by Parthenon and triggered when there is a transition.

### To active

This is going from any state to an active state.

```PHP
use Parthenon\Subscriptions\Transition\ToActiveTransitionInterface;
use Parthenon\Subscriptions\Subscriber\SubscriberInterface;

class Reenable implements ToActiveTransitionInterface
{
    public function transition(SubscriberInterface $subscriber): void
    {
       // re-enable subscription
    }
}
```

### To Overdue

This is going from any state to an overdue state.

```PHP
use Parthenon\Subscriptions\Transition\ToOverdueTransitionInterface;
use Parthenon\Subscriptions\Subscriber\SubscriberInterface;

class WarnOverdue implements ToOverdueTransitionInterface
{
    public function transition(SubscriberInterface $subscriber): void
    {
       // Send warning email about being overdue
    }
}
```

### To Cancelled

This is going from any state to a cancelled state.

```PHP
use Parthenon\Subscriptions\Transition\ToCancelledTransitionInterface;
use Parthenon\Subscriptions\Subscriber\SubscriberInterface;

class CancelSubscription implements ToCancelledTransitionInterface
{
    public function transition(SubscriberInterface $subscriber): void
    {
       // Disable access
    }
}
```
