---
title: "User Logging"
date: 2020-08-25T20:21:11+02:00
draft: false
---
The user logging

| Level | Message  | When it gets written | Notes |
| --- | --- | --- | --- |
| INFO | User sign up page called | When someone makes a HTTP request to the user sign up page | n/a |
| INFO | User reset password page called | When someone makes a HTTP request to the reset password page | n/a |
| INFO | User change password page called | When someone makes a HTTP request to the change password page | n/a |
| INFO | User confirm reset password page called | When someone makes a HTTP request to the confirm reset password page | n/a |
| INFO | User profile page called | When someone makes a HTTP request to the user profile page | n/a |
| INFO | User confirm email page called | When someone makes a HTTP request to the confirm email page | n/a |
| INFO | User login page called | When someone makes a HTTP request to the user login page | n/a |
| WARNING | No user found | When someone tries to login but no user is found for the username/email | n/a |
| INFO | User found during login process | When someone tries to login and the user is found for the username/email. | n/a |
| WARNING | Login failed because invalid password | When someone tries to login but the password is incorrect | n/a |
| WARNING | Login failed because user is not confirmed | When someone tries to login with the correct password but the email is not confirmed | n/a |
| INFO | Password confimed | When someone tries to login and the password is confirmed as valid | n/a |
| WARNING | A user has tried to reset their password with an used code | When someone uses an old/already used reset password link | code is in context |
| WARNING | A user has tried to reset their password with an expired code | When someone uses a reset password link that is older than the allowed time | code is in context |
| INFO | A user has reset their password | When someone successfully resets their password | n/a |
| WARNING | Attempt to reset password for an account that doesn't exist | When someone attempts to do password forgotten on a nonexistant account. | n/a |
| INFO | A user has confirmed their email | When a user successfully confirms their email | n/a |
