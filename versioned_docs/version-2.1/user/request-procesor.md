---
title: "Request Processor"
date: 2020-08-27T21:26:07+02:00
draft: false
---
The way the user system processes HTTP requests for each of the functions of the user system via a class within the `Parthenon\User\RequestProcessor` namespace with a method `process` which accepts one parameter the Symfony Request object.

* ChangePassword
* ConfirmEmail
* PasswordReset
* PasswordResetConfirm
* Profile
* UserSignup

## User Login

With the user login system on a successful login it returns the user object. This can be formattered sepecially for user by overriding the `Parthenon\User\Formatte\UserFormatterInterface`

### Default Formatter

```php
<?php

declare(strict_types=1);

/*
 * Copyright Iain Cambridge 2020-2022, all rights reserved.
 */

namespace Parthenon\User\Formatter;

use Parthenon\User\Entity\User;

final class UserFormatter implements UserFormatterInterface
{
    public function format(User $user): array
    {
        return [
            'username' => $user->getUserIdentifier(),
            'roles' => $user->getRoles(),
        ];
    }
}
```