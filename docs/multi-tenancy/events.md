---
title: "Multi-Tenancy - Events"
date: 2020-08-27T20:33:06+02:00
draft: false
sidebar_label: "Events"
---
One of the easiest ways to extend the Multi-Tenancy system is to hook into the events. Here is the list

## Tenant Sign Up
| When | Events | Methods |
| --- | --- | --- |
| Before the tenant signup process has started. | `Parthenon\MultiTenancy\Event\PreTenantSignupEvent::NAME` | `getTenant` |
| After the tenant signup process been completed. | `Parthenon\MultiTenancy\Event\PostTenantSignupEvent::NAME` | `getTenant` |
| After the Tenant has been created | `Parthenon\MultiTenancy\Event\TenantCreatedEvent::NAME` | `getTenant` |
