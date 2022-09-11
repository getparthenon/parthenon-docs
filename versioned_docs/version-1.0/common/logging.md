---
title: "Common Logging"
date: 2020-08-31T17:41:58+02:00
draft: false
---
Parthenon aims to provide a base level of diagnostic logging. That is to provide a level of logging that if something goes wrong you're able to figure out what the issue is via the logs. This level of logging is useful in large high traffic applications where things go wrong for a few users but not for employees or developers. In these cases, you need to see what happened during the process for that request. Logs can also be used for analytical purposes to understand how your application is being used and the value in certain features.

## Trait

To make logging easy and not make testing harder, parthenon comes with a trait that can be added to classes that provides a logger and if no logger is set then it provides a null logger. This allows you to log what you need but for your unit tests to be unaware of the logger and for your tests not to break because you changed a log message.

When this trait is used and the common CompilerPass is used then the logger will automatically be set.

### Example

```php
use Parthenon\Common\LoggerAwareTrait;
class RandomClass {
    use LoggerAwareTrait;
    public function execute() {
        $this->getLogger()->info("A message here");
    }
}
```

## Processors

To make debugging easier there are a few Monolog processors with parthenon.

| Name | Data Added | Description |
| --- | --- | --- |
| UserProcessor | user_id | Add the user id of the logged-in user. This allows for tracking what user did what and tracking what a user did to debug how bug occurred. |
| ProcessIdProcess | process_id | Adds a process id that is unique to either the HTTP request or the command run. This allows finding all the logs for a request and figuring out how an outcome occurred. |
| PasswordFilter| n/a | This goes through the data in the logs and removes any with the key `password`. This is to help you to avoid accidentally logging people's passwords in plain text. |
| RequestProcessor | request_uri and request_method | Add information about the HTTP request to allow understanding how the request was made therefore the context of the logs. |
