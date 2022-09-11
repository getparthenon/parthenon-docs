---
title: "Getting Started With Parthenon"
date: 2020-08-25T20:18:31+02:00
draft: false
sidebar_position: 2
---
To get started using Parthenon you have two options to get started with Parthenon. Start with the skeleton Application that provides you with a Symfony application, docker, behat tests, and a Vue UI. Or you can add Parthenon to a pre-existing application.

## Set up composer

No matter what way you're going to start using Parthenon you need configure composer to authenticate with our private packagist.

You'll need to token and repository URL for the private packagist instance. You can get this from the [Parthenon Customer Portal](https://customers.parthenon.cloud).

Once you have these credentials then you need to run the following commands.

```
composer config --global repositories.private-packagist composer [YOUR_URL_HERE]
composer config --global --auth http-basic.packagist.parthenon.cloud token [YOUR_TOKEN_HERE]
```

## Using the Skeleton App

Once you have configured composer to use the private packagist to create a skeleton Parthenon app you need to use the `composer create-project` command.

If you're using the bootstrap edition: `composer create-project parthenon/bootstrap-skeleton --repository=[YOUR_URL_HERE]`

If you're using the funded edition: `composer create-project parthenon/skeleton --repository=[YOUR_URL_HERE]`

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

If you're using the bootstrap edition: `composer require parthenon/bootstrap`

If you're using the funded edition: `composer require parthenon/parthenon`
