---
title: "Unfinished Funnels"
date: 2020-08-28T21:25:14+02:00
draft: false
---
This command allows companies to execute actions on unfinished funnels. This can be useful for sending unfinished funnels to business developers as a lead which they can then follow up on. Another use case would be to send people emails inviting them to finish the funnel.

To be able to use this command there are two things that need to be implemented.

# FunnelRepositoryInterface

The `FunnelRepositoryInterface` extends the `RepositoryInterface`.

## Method : `getUnfinnishedToBeProcessed() : array`

This method finds the unfinished funnel entities to be processed.

# UnfinnishedActions\ActionInterface

## Method : `supports($entity): bool`

This method returns true or false based on the fact that this entity is supported by this action.

## Method : `process($entity)`

This method contains all the logic for the action.


# To execute

The command to run is `parthenon:funnel:process-unfinished`.
