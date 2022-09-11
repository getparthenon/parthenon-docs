---
title: "Funnel - Overview"
date: 2020-08-25T18:58:01+02:00
draft: false
sidebar_position: 1
sidebar_label: "Overview"
---
A funnel is a series of forms that a user needs to fill out in order. Funnels are normally used for either user sign up or lead generation forms.


## Features
* Elements of the funnel defined as a separate class.
* An independent success handler to execute upon.
* A command to notify someone of unfinnished funnels.

## Getting Started

To get started with a funnel you need to get an instance of `FunnelInterface` from the service container. The things that must be defined is the entity, at least one `Step`, and the `SuccessHandler` that will be ran on completion of the funnel.

* [How to create a Step](steps.md)
* [How to create a SuccessHandler](successhandler.md)


```php

    /**
     * @Route("/request-demo", name="app_request_demo")
     * @Template("demo/form.html.twig")
     */
    public function funnel(Request $request, FunnelInterface $funnel)
    {
        return $funnel
            ->setEntity(new DemoRequest())
            ->addStep(new StepOne())
            ->addStep(new StepTwo())
            ->setSuccessHandler(new SuccessHandler())
            ->process($request);
    }
```

## Methods

### setEntity

This is the method to define which entity is to be populated by the funnel.


| Name | Type | Description | Example |
| --- | --- | --- | --- |
| entity | object | The entity that is to be populated by the funnel | new DemoRequest |

### addStep

Adds a step to the funnel. Steps are called in order of them being added.

| Name | Type | Description | Example |
| --- | --- | --- | --- |
| step | StepInterface | A step object | new StepOne() |

### setSuccessHandler

The code to be run at the end of the funnel

| Name | Type | Description | Example |
| --- | --- | --- | --- |
| successHandler | SuccessHandlerInterface | The success handler object | new SuccessHandler() |

### setRepository

The repository that is to be injected into RepositoryAware Steps and SuccessHandlers.

| Name | Type | Description | Example |
| --- | --- | --- | --- |
| repository | RepositoryInterface | A data source respository | DoctrineCrudRepository |

### process

| Name | Type | Description | Example |
| --- | --- | --- | --- |
| request | Request | The symfony HTTP request that is to be processed as part of the funnel. | $request |

## Data Storage

The funnel stores data in the session. So this means if you come back to the funnel it will keep your previous state by default. There is a `clear` flag which if sent during a GET request will create a new state for the funnel.

### Clear flag

Just add the `?clear` to the form URL. This is useful for the start of your funnel.
