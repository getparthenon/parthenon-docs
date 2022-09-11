---
title: "Commands"
date: 2020-08-27T20:33:06+02:00
draft: false
---
Sometimes you need to do some user management manually and it can be easier to do this via commands. To help with these problems there are user commands to help with some of the basic tasks.

All commands accept their arguments via command line arguments or via inputs once the command has run when ran without arguments.

To run these you need to access the application via a shell and run the `bin/console <command>`.

## parthenon:user:change-password

Allows you to change the password for a user.

Arguments are

* email
* password

## parthenon:user:confirm

Allows you to mark a user as having a confirmed email address.

Arguments are:

* email

##  parthenon:user:create

Allows you to create a user.

Arguments are:

* email
* Password

## parthenon:user:give-role

Allows you to give a role to a user.

Arguments are:

* email
* role

## parthenon:user:remove-role

Allows you to remove a role from a user.

Arguments are:

* email
* role

## parthenon:user:soft-delete

Allows you to soft delete a user.

Arguments are:

* email
