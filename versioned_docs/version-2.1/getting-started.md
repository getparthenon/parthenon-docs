---
title: "Getting Started With Parthenon"
date: 2020-08-25T20:18:31+02:00
draft: false
sidebar_position: 2
---
To get started using Parthenon you have two options to get started with Parthenon. Start with the skeleton Application that provides you with a Symfony application, docker, behat tests, and a Vue UI. Or you can add Parthenon to a pre-existing application.

## Download from GitHub

You can download the source code from GitHub.

* Parthenon Bundle: https://github.com/getparthenon/parthenon
* Parthenon Skeleton App: https://github.com/getparthenon/skeleton

## Using the Skeleton App

To create a skeleton Parthenon app you need to use the `composer create-project` command.

```
composer create-project parthenon/skeleton
```

This will create a folder with a symfony application that is preconfiged to use Parthenon and includes the basic functionality to get you up and running.

### Get development env working

The skeleton app comes with a docker set up. You need to have `docker-compose` installed.

```
cd docker
docker-compose up -d
```

The skeleton app comes with a reactive frontend UI. To enable this in your development env you need to have yarn installed.

```
yarn
yarn encore dev-server --hot
```

And for the first run to create the databases

```
bin/console doctrine:migrations:migrate
```

## Using with a Pre-Existing application

Once you have configured composer to use the private packagist to add to a pre-existing application you need to use the `composer require` command.

```
composer require parthenon/parthenon
```
