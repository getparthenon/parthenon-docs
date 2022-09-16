---
title: "Skeleton - Overview"
date: 2020-08-25T18:51:52+02:00
draft: false
sidebar_label: "Overview"
---
Parthenon comes with a Skeleton application. Currently it comes in two flavours based on which database you want to use Postgres or MongoDB. Other than the database these skeleton applications are the same, the come with the same functionality and tooling.

You can find this at https://github.com/getparthenon/skeleton.

## Create  

To create a new project you just need to use the `composer create-project` command.

```
composer create-project partheon/skeleton
```

## Development Env

The skeleton applications come with a docker-compose configuration that will configure a development environment.

If you wish to be able to run the symfony console command locally instead of within a docker container then you need to have the following PHP modules installed.

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

### Docker

The skeleton application comes with a `docker-compose.yaml` that will create a functional development environment.

For the PHP-FPM container it uses by default the Parthenon PHP 8.1 container that comes with the required modules installed. This docker container is rebuild nightly to ensure it gets the latest security updates. You can check out the builds at https://github.com/getparthenon/packer-config.

## Tests

The skeleton application comes with behat tests for all the skeleton application functionality.

To run these you just run.

```
vendor/bin/behat
```

You can find out more on how to work with Behat at [https://docs.behat.org/en/latest/](https://docs.behat.org/en/latest/)

## Continuous Integration

The skeleton application comes with the configuration for Github Actions in `.github/workflows/main.yaml` and for Bitbucket pipelines in `bitbucket-pipelines.yaml`.

These will run the following:

* php-cs-fixer - To check the code style.
* phpunit - To tun PHPUnit tests
* behat - To run the behat tests
