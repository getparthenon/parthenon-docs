---
title: "Send Templated User Emails"
date: 2020-08-25T20:18:40+02:00
draft: false
---
Sending emails using your user emails using templates is one of the required things for a professional setups.

## Step 1. Modify message factory

You need to extend `Parthenon\User\Notification\MessageFactory` and override methods to change the user emails. You only need to override methods you want to change.

```php
<?php
namespace App\User\Notification;

use Parthenon\User\Entity\ForgotPasswordCode;
use Parthenon\User\Entity\UserInterface;
use Parthenon\Notification\Message;
use Parthenon\User\Notification\MessageFactory as BaseMessageFactory;
use Parthenon\User\Notification\UserMessage;

class MessageFactory extends BaseMessageFactory
{
    public function getUserSignUpMessage(UserInterface $user): Message
    {
        $message = UserMessage::createFromUser($user);
        $message->setTemplateName('d-template-id');
        $message->setTemplateVariables(['confirm_url' => rtrim($this->config->getSiteUrl(), '/').'/user/confirm/'.$user->getConfirmationCode()]);

        return $message;
    }

    public function getPasswordResetMessage(UserInterface $user, ForgotPasswordCode $passwordReset): Message
    {
        $message = UserMessage::createFromUser($user);
        $message->setTemplateName('d-template-id')
            ->setTemplateVariables(['confirm_url' => rtrim($this->config->getSiteUrl(), '/').'/user/reset/'.$passwordReset->getCode()]);

        return $message;
    }
}
```


## Step 2. Update services to use new version

```YAML
    Parthenon\User\Notification\MessageFactory: '@App\User\Notification\MessageFactory'
```
