---
title: "Skeleton - Overview"
date: 2020-08-25T18:51:52+02:00
draft: false
sidebar_label: "Overview"
---
Parthenon comes with Skeleton applciations. Currently it comes in two flavours based on which database you want to use Postgres or MongoDB. Other than the database these skeleton applications are the same, the come with the same functionality and tooling.

## Create  

There are four options to create an application. If you're on the bootstrap edition then you need to use a bootstrap skeleton. Otherwise, you can use the fully loaded application.

* `partheon/skeleton`
* `partheon/bootstrap-skeleton`
* `partheon/mongodb-skeleton`
* `partheon/bootstrap-mongodb-skeleton`

```
composer config --global repositories.private-packagist composer https://packagist.parthenon.cloud/example/
composer config --global --auth http-basic.packagist.parthenon.cloud token EXAMPLE-TOKEN
composer create-project partheon/skeleton super-awesome-saas
```

## Development Env

The skeleton applications come with a docker-compose configuration that will configure a development enviorment.

If you wish to be able to run the symfony console command localy instead of within a docker container then you need to have the following PHP modules installed.

* php8.1-curl
* php8.1-dom
* php8.1-fpm
* php8.1-intl
* php8.1-xml
* php8.1-mbstring
* php8.1-zip
* php8.1-redis
* php8.1-pgsql (if you want to use Postgres)
* php8.1-mongodb (if you want to use MongoDB)

## Tests

The skeleton application comes with behat tests for all the skeleton application functionality.

To run these you just run.

```
vendor/bin/behat
```

You can find out more on how to work with Behat at [https://docs.behat.org/en/latest/](https://docs.behat.org/en/latest/)

## Continuous Integration

The skeleton application comes with the configuration for Github Actions in `.github/workflows/main.yaml` and for Bitbucket pipelines in `bitbucket-pipelines.yaml`. These will build

The continious integration environments need the following env secrets variables

| Name | Description | Example Usage |
| --- | --- | --- |
| PACKAGIST_USERNAME | the username in the packagist url. | https://packagist.parthenon.cloud/$PACKAGIST_USERNAME/ |
| PACKAGIST_TOKEN | the packagist token | Used in the composer auth command |
