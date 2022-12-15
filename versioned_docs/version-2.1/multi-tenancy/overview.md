---
title: "MultiTenancy - Overview"
date: 2020-09-04T17:30:32+02:00
draft: false
sidebar_label: "Overview"
---
The Multi-Tenancy feature provides support for a multi-tenancy system where each tenant has their own database.

:::note

Multi-Tenancy in a single database is supported by default.

:::

### Configuration

There are some configurations for the user module of Parthenon. These can be configured within the parthenon.yaml Symfony configuration file that should be within the `config/packages/` directory of your Symfony application.

| Name | Type | Description | Default Value |
| --- | --- | --- | --- |
| enabled | Boolean | To define if the user module is enabled. | false |
| domain | Boolean | Defines if teams are enabled. If they are a team is created upon a new user sign up. | n/a |
| database_creation_strategy | String | How the database is created either `dbal`/`digitalocean` | dbal |
| doctrine.dbal_connection | String | The dbal connection that is to be used for the tenant conneciton. | n/a |
| doctrine.global_dbal_connection | String | The dbal connection that is to be used for the global conneciton. | n/a |
| doctrine.orm_entity_manager | String | The dbal connection that is to be used for the tenant orm manager. | n/a |
| migrations.directory | String | The directory where migration for the tenants are stored | n/a |
| digitalocean.cluster_id | String | The digitalocean database cluster id | n/a |

## Doctrine Dbal/ORM Configuration

The DBAL configuration for the tenant connection needs to have the username, password, host, and port provided.

The `wrapper_class` option must have the value `Parthenon\MultiTenancy\Dbal\TenantConnection`

There must also be a default database given.

There should be two entity managers one for the global connection, that is information that is needed for all tenants. Namely, the tenant database of what tenants exist. It is a good idea to use two different namespaces for the entities.

### Example configuration

```yaml
doctrine:
    dbal:
        default_connection: default
        connections:
            default:
                url: '%env(resolve:DATABASE_URL)%'
            multi_tenant:
                user: '%env(resolve:TENANT_DATABASE_USER)%'
                password: '%env(resolve:TENANT_DATABASE_PASSWORD)%'
                host: '%env(resolve:TENANT_DATABASE_HOST)%'
                port: '%env(resolve:TENANT_DATABASE_PORT)%'
                dbname: '%parthenon_multi_tenancy_default_database%'
                wrapper_class: Parthenon\MultiTenancy\Dbal\TenantConnection
                driver: pdo_pgsql
    orm:
        auto_generate_proxy_classes: true
        resolve_target_entities:
            Parthenon\User\Entity\UserInterface: App\Entity\User
            Parthenon\User\Entity\TeamInterface: App\Entity\Team
            Parthenon\MultiTenancy\Entity\TenantInterface: App\Entity\Tenant
        entity_managers:
            global:
                connection: default
                naming_strategy: doctrine.orm.naming_strategy.underscore_number_aware
                auto_mapping: false
                mappings:
                    AppGlobal:
                        is_bundle: false
                        type: annotation
                        dir: '%kernel.project_dir%/src/GlobalEntity'
                        prefix: 'App\GlobalEntity'
                        alias: AppGlobal
            multi_tenant:
                connection: multi_tenant
                naming_strategy: doctrine.orm.naming_strategy.underscore_number_aware
                auto_mapping: true
                mappings:
                    App:
                        is_bundle: false
                        type: annotation
                        dir: '%kernel.project_dir%/src/Entity'
                        prefix: 'App\Entity'
                        alias: App
```

## Migrations

To execute the migrations `parthenon:multi-tenancy:migrate`. This will loop through the tenants and run the migrations.


:::note
When a new tenant database is created it'll have all the current migrations marked as done.
:::


### To Generate

Currently, the suggested way of generating a diff is ` bin/console d:m:diff --em={$doctrine.orm_entity_manager]`. The em value should be the same value in `doctrine.orm_entity_manager`.
