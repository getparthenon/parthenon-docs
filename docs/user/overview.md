---
title: "User - Overview"
date: 2020-08-25T20:19:24+02:00
draft: false
sidebar_position: 1
sidebar_label: "Overview"
---
The user module for Parthenon aims to provide the basic functionality to run an application that supports users. It provides basic functionality for the user system as well as user administration functionality within Athena. It is extendable via Symfony events.

## User Facing Functionality

With the Parthenon User module you'll be able to:

### Sign Up

This allows the user to sign up.

This is customisable in the following ways:

* Emails
* Sign up form
* [User Events](events.md#user-sign-up)
* Team creation

### Login

This is when the user logs in.

This is customisable in the following ways:

* Login Redirect Path

### Recover your password

This allows the user to recover their password.

{{% notice info %}}
If a user has not confirmed their account but tries to recover their password it will activate their account upon the password being reset.
{{% /notice %}}

This is customisable in the following ways:

* Emails
* [User Events](events.md#forgot-password)

### Confirm your account

This allows the user to confirm their account.

This is customisable via:

* [User Events](events.md#user-confirm)

### Invite users

This sends an invite for someone to sign up.

This is customisable via:

* [User Events](events.md#user-invite)

### Invite team members

This sends an invite for someone to sign up.

This is customisable via:

* [User Events](events.md#team-user-invite)

### Change Password

When the user changes their password

This is customisable via:

* [User Events](events.md#password-change)

### Profile

This is when the user updates their user profile

This is customisable via:

* [User Events](events.md#profile)

## Athena

The User Module has it's own section within Athena to allow you to manage the users.

The actions that can be done within Athena are:

### GDPR delete

This is when the user has requested for a GDPR level delete. It checks to see if the user is eligible to be fully deleted from the system using voters defined by the application.

### GDPR export

This provides the user a machine readable export as is required by GDPR. To generate the export the system users exporters as defined by the application.

### Soft delete

This is when the user doesn't need to be fully deleted and the data can be stored.
