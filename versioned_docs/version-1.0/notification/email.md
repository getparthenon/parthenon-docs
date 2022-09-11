---
title: "Email"
date: 2020-08-25T20:18:31+02:00
draft: false
---
Parthenon provides a robust system for sending emails which is easy to configure allowing you to start sending emails quickly. With our Email abstraction you'll be able to send emails and quickly switch from Email Service Providers with just a configuration.

## Configuration

| Config Name | Example | Required | Description |
| --- | --- | --- | --- |
| from_name | Parthenon | false | The name of the email sender |
| from_address | parthenon@example.org | false | The address of the email address |
| provider | sendgrid | false | The mailing service to be used. Options are: null, sendgrid, mailgun, postmark,symfony |
| mailgun | n/a | false | The mailgun options as defined in the [Mailgun](#mailgun) section below. |
| sendgrid | n/a | false | The sendgrid options as defined in the [SendGrid](#sendgrid) section below. |
| postmark | n/a | false | The postmark options as defined in the [Postmark](#postmark) section below. |
| send_via_queue | false | false | When this flag is true then you can use the Symfony Messenger queue functionality to send the emails. |

### Example


```YAML
parthenon:
  notification:
    enabled: true # by default is false.
    email:
      from_name: 'Parthenon'
      from_address: 'parthenon@example.org'
      provider: sendgrid
      sendgrid:
        api_key: 'a-cool-api-key-from-sendgrid'
```

## Sending Emails

How sending emails work is that you create and message object from `Parthenon\Notification\Message` that is filled with the information for the email. This includes attachments, subject, and if there is a template name/id then that as well.

### Parthenon\Notification\Message

This is the base class that forms the object representing the email that should be sent.

#### Methods

| Method Name | Arguments | Return Value | Description |
| --- | --- | --- | --- |
| setSubject  | ?string $subject | self | Set the subject for the email |
| getSubject | n/a | ?string | Returns the subject for the email |
| getFromAddress | n/a | ?string | Returns the email address that the email should be sent from |
| setFromAddress | ?string $fromAddress | self | Sets the email address that the email should be sent from |
| getFromName | n/a | ?string | Returns the name that the email should be sent from |
| setFromName | ?string $fromName | self | Sets the name that the email should be sent from |
| getToAddress | n/a | ?string | Returns the email address that the email should be sent to |
| setToAddress | ?string $toAddress | self | Sets the email address that the email should be sent to |
| getToName | n/a | ?string | Returns the name that the email should be sent to |
| setToName | ?string $toName | self | Sets the name that the email should be sent to |
| getContent | n/a | ?string | Returns the content for the email. *This is only used if the template name is not set.* |
| setContent | ?string $content | self | Sets the content for the email. *This is only used if the template name is not set.* |
| getTemplateName | n/a | ?string | Returns the name of the template. *With sendgrid this is the template id* |
| setTemplateName | ?string $templateName | self | Sets the name of the template. *With sendgrid this is the template id* |
| getTemplateVariables | n/a | array | Returns the variables for the template. |
| setTemplateVariables | array $templateVariables | self | Sets the variables for the template. |
| isTemplate | n/a | bool | Returns if it's a template based email or not. |
| addAttachment | Attachment $attachment | self | Adds an attachement to be sent |
| getAttachments | n/a | array | Returns the attachments to be sent with the email. |

### Parthenon\User\Notification\UserMessage

This is a helper class that creates an email for a user that automatically fills the name and address of the recipient of the email. It also adds the name of the user to the template variables under `name`.

#### Methods

| Method Name | Arguments | Return Value | Description |
| --- | --- | --- | --- |
| createFromUser | UserInterface $user | self | A static factory method. |

### Parthenon\Notification\Attachment

This is a class that represents the attachment that is being sent.

the template variables under `name`.

#### Methods

| Method Name | Arguments | Return Value | Description |
| --- | --- | --- | --- |
| __construct | string $name, mixed $content | self | The constructor, the only way to set data for an Attachment is via the constructor |
| getName| n/a | string | Returns the filename of the attachment. |
| getContent | n/a | string | Returns the content of the attachment file. |

### Example

```php
$user = new User();
$sender = new Sender();

$userMessage = \Parthenon\User\Notification\UserMessage::createFromUser($user);

// SendGrid Template
// With SendGrid you only need to provide the template id as the subject comes from the template.
$userMessage->setTemplate('sendgrid-template-id');


// Mailgun template
// With Mailgun you need to set the subject
$userMessage->setTemplate('mailgun-template-name');
$userMessage->setSubject('The subject needs to be provided');

// Attachment
$attachment = new Parthenon\Notification\Attachment('filename.txt', 'file contents');
$userMessage->addAttachment($attachment);

$sender->send($userMessage);
```

## SendGrid

To send emails via SendGrid you need to set the sender to SendGrid and provide an API Key.

{{% notice info %}}
When you send an email using the SendGrid templates you don't need to set the subject.
{{% /notice %}}

| Config Name | Example | Required | Description |
| --- | --- | --- | --- |
| api_key | asjdiofghds | true | The API key for SendGrid |

```YAML
parthenon:
  notification:
    enabled: true # by default is false.
    email:
      from_name: 'Parthenon'
      from_address: 'parthenon@example.org'
      provider: sendgrid
      sendgrid:
        api_key: 'a-cool-api-key-from-sendgrid'
```

## Postmark

To send emails via Postmark you need to set the sender to Postmark and provide an API Key.

| Config Name | Example | Required | Description |
| --- | --- | --- | --- |
| api_key | asjdiofghds | true | The API key for Postmark |

```YAML
parthenon:
  notification:
    enabled: true # by default is false.
    email:
      from_name: 'Parthenon'
      from_address: 'parthenon@example.org'
      provider: postmark
      postmark:
        api_key: 'a-cool-api-key-from-postmark'
```

## Mailgun

To send emails via Mailgun you need to set the sender to Mailgun and provide an API Key and domain.

| Config Name | Example | Required | Description |
| --- | --- | --- | --- |
| api_key | asjdiofghds | true | The API key for Mailgun |
| api_url | https://api.eu.mailgun.net | false | The domain for the Mailgun API. *Normally only set to use EU servers instead of US ones.* |
| domain | example.org | true | The domain you'll be sending emails from. The from email must match this domain. |

```YAML
parthenon:
  notification:
    enabled: true # by default is false.
    email:
      from_name: 'Parthenon'
      from_address: 'parthenon@example.org'
      provider: mailgun
      mailgun:
        api_key: 'a-cool-api-key-from-mailgun'
        api_url: 'https://api.eu.mailgun.net'
        domain: 'domain-that-you-send-emails-from.com'
```
