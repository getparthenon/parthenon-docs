---
title: "Events"
date: 2020-08-27T20:33:06+02:00
draft: false
---
One of the easiest ways to extend the user system is to hook into the events. Here is the list

## Forgot Password

| When | Events | Methods |
| --- | --- | --- |
| Before the password reset process has started. | `Parthenon\User\Event\PrePasswordResetEvent::NAME` | `getUser`, `getPasswordReset` |
| After the password reset email has been completed. | `Parthenon\User\Event\PostPasswordResetEvent::NAME` | `getUser`, `getPasswordReset` |
| Before the password has been reset when the user has clicked on the link. | `Parthenon\User\Event\PrePasswordResetConfirmEvent::NAME` | `getUser` |
| After the password has been reset when the user has clicked on the link. | `Parthenon\User\Event\PostPasswordResetConfirmEvent::NAME` | `getUser` |

## Password Change

| When | Events | Methods |
| --- | --- | --- |
| Before the password is changed when the user is logged in. | `Parthenon\User\Event\PostPasswordChangeEvent::NAME` | `getUser` |
| After the password is changed when the user is logged in. | `Parthenon\User\Event\PrePasswordChangeEvent::NAME` | `getUser` |

## Profile

| When | Events | Methods |
| --- | --- | --- |
| Before the user profile is changed when the user is logged in. | `Parthenon\User\Event\PreProfileEvent::NAME` | `getUser` |
| After the user profile is changed when the user is logged in. | `Parthenon\User\Event\PostProfileEvent::NAME` | `getUser` |

## User Confirm

| When | Events | Methods |
| --- | --- | --- |
| Before the user is confirmed when the user clicks the link. | `Parthenon\User\Event\PreUserConfirmEvent::NAME` | `getUser` |
| After the user is confirmed when the user clicks the link. | `Parthenon\User\Event\PostUserConfirmEvent::NAME` | `getUser` |

## User Sign up

| When | Events | Methods |
| --- | --- | --- |
| Before the user creation process has started. | `Parthenon\User\Event\PreUserSignupEvent::NAME` | `getUser` |
| After the user has been created. | `Parthenon\User\Event\PostUserSignupEvent::NAME` | `getUser` |
| When a user who was invited signs up | `Parthenon\User\Event\InvitedUserSignedUpEvent::NAME` |  `getUser`, `getInviteCode` |

## User Invite

| When | Events | Methods |
| --- | --- | --- |
| Before the user invite process has started | `Parthenon\User\Event\PreInviteEvent::NAME` | `getUser`, `getInviteCode` |
| After the user invite has been created. | `Parthenon\User\Event\PostInviteEvent::NAME` | `getUser`, `getInviteCode` |

## Team User Invite

| When | Events | Methods |
| --- | --- | --- |
| Before the team user invite process has started | `Parthenon\User\Event\PreTeamInviteEvent::NAME` | `getUser`, `getInviteCode`, `getTeam` |
| After the team invite has been created. | `Parthenon\User\Event\PostTeamInviteEvent::NAME` | `getUser`, `getInviteCode`, `getTeam` |
