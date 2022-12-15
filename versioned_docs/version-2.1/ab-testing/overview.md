---
title: "A/B Testing - Overview"
date: 2020-08-25T18:51:52+02:00
draft: false
sidebar_label: "Overview"
---
A/B Testing is one of the core things companies need to do to truly understand if
their changes actually improve the the KPIs they want to improve.

## Configuration

| Name | Example | Default | Description |
| --- | --- | --- | --- |
| enabled | true | false | Defines if A/B Testing is enabled. |
| provider | parthenon | parthenon | Defines which provider is to be used for A/B testing, parthenon and optimizely are supported |
| report_handler_service | App\AbtTesting\ReportHandler | null | The symfony service that is to be used to generate reports |
| dbal_connection_service | Doctrine\DBAL\Connection | null | The dbal connection to be used to talk to timescaledb |
| log_user_results | true | false | This defines if the results (user_signup, login, etc) within the user module should be logged. |
| predefined_decisions_enabled | true | false | This defines if it is possible to make an experiment defaulted to a specific variant. |
| predefined_decisions_redis_service | App\AbTesting\Redis | null | The symfony service with the Redis connection. |
| disabled_user_agents | See example | null | The user agents that A/B Testing shouldn't be enabled for. |

```yaml
parthenon:
  ab_testing:
    enabled: true
    provider: 'parthenon'
    optimizely:
      api_key: 'API KEY FOR OPTIMIZELY'
    parthenon:
      dbal_connection_service: 'Doctrine\DBAL\Connection'
      log_user_results: true
      report_handler_service: 'App\AbTesting\ReportHandler'
      predefined_decisions_enabled: true
      predefined_decisions_redis_service: 'Redis'
      disabled_user_agents:
        - 'Go\-http\-client'
        - 'python'
        - 'Google'
        - 'bingbot'
        - 'SemrushBot'
        - 'AhrefsSiteAudit'
        - 'AhrefsBot'
        - 'SeznamBot'
        - 'SaaSHub'
        - 'expanseinc'
        - 'masscan'
        - 'Kryptos Logic Telltale'
        - 'zgrab'
        - 'PocketImageCache'
        - 'Linux Gnu \(cow\)'
        - 'Slackbot'
        - 'Java'
        - 'Hello, World'
        - 'TweetmemeBot'
        - 'CensysInspect'
        - 'YandexBot'
        - 'ZmEu'
        - 'curl'
        - 'SEOkicks'
        - 'GRequests'
        - 'Barkrowler'
        - 'BLEXBot'
        - 'http(s)?\:\/\/'
        - 'Xenu'
        - 'Go http'
        - 'Twitterbot'
        - 'facebookexternalhit'
        - 'Facebot'
        - 'adbeat'
        - 'NetSystemsResearch'
        - 'Cloudflare-SSLDetector'
```

## Report

Getting a daily or weekly PDF can be very useful to get an overview of how experiments are going. There is a command `parthenon:ab-testing:generate-report` which generates a PDF and will call the report handler defined in the configuration.

To create a report handler you need to implement `Parthenon\AbTesting\Report\ĢenerationHandlerInterface` with a single method that accepts the PDF content as a string.

```php
/*
 * Copyright Iain Cambridge 2020-2021, all rights reserved.
 */

namespace Parthenon\AbTesting\Report;

interface GenerationHandlerInterface
{
    public function handle(string $report): void;
}
```

## Log User Results

Some of the core things you may want to experiment on are part of the the user module.

| Result | When it is record |
| --- | --- |
| user_login | When a user logins. It triggered by the InteractiveLoginEvent. |
| user_signup | When a user signups. It is triggered by the PostUserSignupEvent. |
| user_email_confirmed | When a user confirms emails. |

## Predefined Decisions

As you create and run experiments you'll find out results and will want to end the experiment and have the winner of the experiment to be used everytime. To allow you to move quickly and not be slowed down by waiting for developers to remove the A/B code this can be done via Athena.

## Disabled User Agents

In order to avoid having your experiments ruined by bots and other automated traffic we've added the ability to disable A/B testing for user agents. The user agents in the list can use regex.

Here is our recommended list.

```YAML
parthenon:
  ab_testing:
    parthenon:
      disabled_user_agents:
        - 'Go\-http\-client'
        - 'python'
        - 'Google'
        - 'bingbot'
        - 'SemrushBot'
        - 'AhrefsSiteAudit'
        - 'AhrefsBot'
        - 'SeznamBot'
        - 'SaaSHub'
        - 'expanseinc'
        - 'masscan'
        - 'Kryptos Logic Telltale'
        - 'zgrab'
        - 'PocketImageCache'
        - 'Linux Gnu \(cow\)'
        - 'Slackbot'
        - 'Java'
        - 'Hello, World'
        - 'TweetmemeBot'
        - 'CensysInspect'
        - 'YandexBot'
        - 'ZmEu'
        - 'curl'
        - 'SEOkicks'
        - 'GRequests'
        - 'Barkrowler'
        - 'BLEXBot'
        - 'http(s)?\:\/\/'
        - 'Xenu'
        - 'Go http'
        - 'Twitterbot'
        - 'facebookexternalhit'
        - 'Facebot'
        - 'adbeat'
        - 'NetSystemsResearch'
        - 'Cloudflare-SSLDetector'
```

## Create an Experiment

To create an experiment you just need to login to Athena click the "AB Tests" then Configure and then click Add new Experiment.

![UI](/images/ab_testing/list.png)

Then you just need to add the variants. You can define as many variants as you want and assign as much of the traffic to that percentage as you want. The total percentage needs to be 100%.

![UI](/images/ab_testing/experiment.png)

## Do Experiment in Twig

We've created a twig extension to make using A/B testing in twig as easy as possible. To allow this we added `ab_do_experiment` this will return a string with the name of the variant to be used for the page request.

### example

```twig
{% if "experiment" == ab_do_experiment('landing_page_title_pain_or_ai') %}
  <h1>It's easy to lose money and not notice!</h1>
{% else %}
  <h1>AI eCommerce Order Monitoring</h1>
{% endif %}
```

## Do Experiment in PHP

To do experiments in other places using PHP you just need to inject `Parthenon\AbTesting\Experiment\DeciderInterface` and then call `doExperiment`. This will return the string of the variant to be used.

```php
use Parthenon\AbTesting\Experiment\DeciderInterface;

class controller
{
  public function action(DeciderInterface $decider)
  {
    $variantName = $decider->doExperiment('landing_page_title_pain_or_ai');

    if ('experiment' === $variantName) {
      // do experiment
    } elseif ('experiment_two' === $variantName) {
      // do second possible experiment
    } else {
      // last possible option, control group
    }
  }
}
```

## Session Clean Up

You may find the need to do a session clean up if you've discovered there are user agents you don't wish to run experiments on. Once you've added the user agents to the banned user agents list then you can run the symfony command `parthenon:ab-testing:cleanup`.

## Optimizely

Parthenon allows you to scale up to the point you will want to use a full featured A/B testing with all the bells and whistle. With a simple configuration change you can swap from using Parthenon's built in A/B testing to using Optimizely.

{{% notice info %}}
Currently, due to Optimizely's SDK not being able to support PHP 8 you need to use okdewit/optimizely-php-sdk. To install do composer require okdewit/optimizely-php-sdk
{{% /notice %}}

```YAML
parthenon:
  ab_testing:
    enabled: True
    provider: 'optimizely'
    optimizely:
      api_key: 'API KEY HERE'
```
