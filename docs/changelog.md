---
title: "Changelog"
date: 2020-08-25T20:18:31+02:00
draft: false
sidebar_position: 98
---
Here you'll be able to see the updates to Parthenon. This page started to be maintained on 21.04.2022.

# v2.2.0 - 27-06-2023

* [AB Testing] Only load doctrine mappings when enabled
* [Athena] Only load doctrine mappings when enabled
* [Athena] Add entity view type
* [Athena] Fix bug in ResultSet getLastKey when no results
* [Athena] Add workaround for embedded fields in filter querybuilder
* [Athena] Add first key to CrudRepository
* [Athena] Add collection form type support
* [Athena] Make form fields uneditable
* [Athena] Add generate section code command
* [Billing] Add module with Plan functionality
* [Billing] Add ability to define Plans from Athena
* [Billing] Add billing address
* [Billing] Make it tooglable to use the database for plans or config
* [Billing] Allow for multiple active subscriptions
* [Export] Only load doctrine mappings when enabled
* [MultiTenancy] Only load doctrine mappings when enabled
* [Payments] Deprecated entire module
* [Payments] Only load doctrine mappings when enabled
* [User] Only load doctrine mappings when enabled

# v2.1.0 - 16-12-2022

* [AB Testing] Fix column names for updated at in Experiment
* [Athena] Add export functionality
* [Common] Add readFile and deleteFile to UploaderInterface
* [Export] Create export module
* [Notification] Add TemplateEmail class to allow defining template name within the class
* [User] Make email confirmation for users togglable

# v2.0.1 - 04-10-2022

* [Payments] Fix Subscriber type configuration

# v2.0.0 - 01-10-2022

* [Athena] Remove dead code in OdmCrudRepository
* [Athena] Use alias in EntityForm for EditField
* [Common] Use alias for Guzzle\ClientInterface in GuzzleFactory
* [Common] Remove nullable on logger in LoggerAwareTrait
* [Common] Add dependency check for mpdf when configured to use mpdf
* [Common] Add dependency check for docraptor when configured to use docraptor
* [Invoice] Update naming and data types in refactor
* [Invoice] Make VatRuleInterface:setVat return void
* [Invoice] Add optional argument to InvoiceNumberGenerator
* [Payments] Merge Subscriptions module
* [Payments] Fix exception flung when trying to cancel a subscription that doesn't exist.
* [Payments] If no cancel route is provided use success route.
* [Payments] Add per seat subscriptions
* [Payments] Rename sync subscription command
* [Payments] Attach customer id to subscription
* [Payments] Move stripe services into separate services.xml
* [RuleEngine] Removed until it can be better implemented
* [Skeleton] New layout for public pages
* [Skeleton] New layout for the internal Application
* [User] Ensure that currently registered members can't be invited
* [User] Add id to the user formatter
* [User] Change user profile to user settings

# v1.2.5 - 22.08.2022

* [User] Add logging to Signup and TeamInvite request processors
* [Subscription] Merge subscriber section with user and team sections
* [Subscriptions] Fix lifetime is active
* [Payments] Add cancel checkout return
* [Payments] Fix exception handling in cancel
* [Payments] Support lifetime deal
* [Athena] Fix create
* [Athena] Add preSave and postSave for edit and create in crud
* [Athena] On successful creation make form empty to show that
* [Common] Field Accessor supports isX and hasX
* [Athena] Fix create form
* [Core] Add container.preload tag to services
* [User] Remove final on ForgotPasswordCode and InviteCode entities
* [Payments] Handle free plan in create checkout
* [Subscription] Add better free subscription
* [Notifications] Inject logger into SendgridSender
* [Notifications] Use from address and name if set
* [Common] Send choices when request handler default
* [Payments] Add logs and sanity check to stripe subscription manager
* [Common] Catch conversion exceptions for invalid uuid ids and other general exceptions in findById
* [Subscriptions] Sync valid until when subscription status is synced and have voters work for active subscriptions
* [User] Make it so timezone aware is optional to have timezone
* [User] Add Timezone aware functionality
* [Payments] Support Stripe trials via subscription data
* [User] Give team a predefined team name

# v1.2.4 - 03.06.2022

* [Skeleton] Fix spelling of config file
* [Skeleton] Make behat tests less brittle
* [Skeleton] Fix responsive view in mobile
* [Skeleton] Add missing translation success change plan
* [Skeleton] Add payment change link
* [Skeleton] Fix translation for cancel plan
* [Skeleton] Fix team repository findAllSubscriptions
* [Skeleton] Update ansible nginx to use php 8.1
* [Athena] add error message on login failure
* [Common] Add monolog exception processor
* [Athena] send just error message to login template
* [Athena] Improve look of edit forms
* [Athena] Allow for editing sub-entities
* [Subscription] Add basic Athena panel to update subscriber plan
* [Subscriptions] Make SubscriptionRepository extend CrudRepository
* [Payments] Add redirect to billing portal
* [User] allow users to have accounts deleted and to sign up again
* [Core] Improve bundle creation scripts to include translations

# v1.2.3 - 25.05.2022

* [Common] Add CSV Exporter
* [Rule Engine] Remove DI invalid tag auto add
* [Subscriptions] Add ability to limit features to plan
* [Skeleton] Update translations

# v1.2.2 - 18.05.2022

* [Athena] Add ability to create dashboard sections
* [User] Add user signed up stats Athena Dashboard section
* [Common] Add error message when wkhtmltopdf bin doesn't exist
* [Common] Fix wkhtmltopdf using incorrect class in stats
* [Multi Tenancy] Add default database parameter
* [AB Testing] Fix session creator throwing exception in CLI
* [AB Testing] Fix decideder throwing exception in CLI
* [Rule Engine] Fix javascript on rule add in Athena
* [Rule Engine] Fix translations

# v1.2.1 - 09.05.2022

* [Skeleton] Add landing page
* [Subscriptions] Fix SyncSubscriptionsCommand using old payment repository

# v1.2 - 04.05.2022

* [Subscriptions] Module created from Plan and Payments
* [MongoDB Skeleton] Skeleton application created
* [User] Fix user limits not being respected when using mongodb
* [User] Fix `TeamInviteCodeOdmRepository::findAllUnusedInvitesForTeam` returning MongoDB object and not array
* [Subscriptions] Add fetch subscription for user
* [Health] Only load Doctrine ORM Health check if Doctrine ORM is installed
* [Notification] Add `WebhookPosterInterface` and `NullWebhookPoster` for slack webhook posts.
* [Notification] Fix SymfonySender throwing non Parthenon exceptions.

# v1.1.1 - 26.04.2022

* [User] Mark user as having a confirmed email when they signed via an Invite
* [Plan] Fix PlanManager throwing GeneralException instead of NoPlanFoundException
* [Plan] Fix The return type for `LimitedUserInterface::getPlanName` to allow nullable when `Subscription::getPlanName` allows nullable.
* [User] Changed default urls for emails to match skeleton users
* [Skeleton] Changed from using VueBootstrap to just Bootstrap directly
* [Skeleton] Change ansible to use php 8.1
* [Skeleton] Add logout link
* [Skeleton] Fix logout loop on login failure
* [Skeleton] Add user with invite signup
* [Skeleton] Use Symfony mailer by default

# v1.1 - 20.04.2022

* Added MultiTenancy module
* Added User Commands
* Added ability to configure user roles on sign up
* Added ability to manage user roles in Athena
* Change tests from PHPSpec to PHPUnit
* Added base for Elasticsearch support
* And various bug fixes
