---
title: "Send Slack Notifcations On Signup"
date: 2020-08-25T20:18:40+02:00
draft: false
---
To get slack notifications of a new user sign up you can hook into the user events, in this case the post user signup event.

```php
<?php

namespace App\User\Event;

use App\Entity\User;
use Parthenon\Notification\Slack\MessageBuilder;
use Parthenon\Notification\Slack\WebhookPosterInterface;
use Parthenon\User\Event\PostUserSignupEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class SignupSubscriber implements EventSubscriberInterface
{
    public function __construct(private WebhookPosterInterface $webhookPoster, private string $webhookUrl)
    {
    }

    public function handleUserSignUp(PostUserSignupEvent $postUserSignupEvent)
    {
        /** @var User $user */
        $user = $postUserSignupEvent->getUser();

        $mb = new MessageBuilder();
        $mb->addMarkdownSection(sprintf(':tada: *A new user has signed up!* %s', $user->getEmail()))->closeSection();

        $this->webhookPoster->send($this->webhookUrl, $mb->build());
    }

    public static function getSubscribedEvents()
    {
        return [
            PostUserSignupEvent::NAME => 'handleUserSignUp',
        ];
    }
}

```

For the purposes of this recipe you ened to have the webhook url you want to use. It's best to create an env variable for this and use the `.env` file

```bash
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/..."
```

In your `services.yaml` file put this to assign the webhook url to the argument since it can't be autowired.

```yaml
services:
  // ...

    App\User\Event\SignupSubscriber:
        arguments:
            $webhookUrl: '%env(resolve:SLACK_WEBHOOK_URL)%'
```

To avoid getting slack notifications from your test suite you want to switch out the webhook poster for a null webhook poster. So in your `services_test.yaml` file put

```yaml

services:
  // ...

    Parthenon\Notification\Slack\WebhookPosterInterface: '@Parthenon\Notification\Slack\NullWebhookPoster'
```
