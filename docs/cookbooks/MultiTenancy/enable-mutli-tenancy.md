---
title: "Enable Multi Tenancy"
date: 2020-08-25T20:18:40+02:00
draft: false
---
To enable multi-tenancy you need to do the following:

Create Tenant repository

```php
<?php

declare(strict_types=1);

/*
 * Copyright Humbly Arrogant Ltd 2020-2022, all rights reserved.
 */

namespace App\Repository\Orm;

use App\Entity\Tenant;
use Doctrine\Persistence\ManagerRegistry;
use Parthenon\Common\Repository\CustomServiceRepository;

class TenantRepository extends CustomServiceRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Tenant::class);
    }
}
```

Update the doctrine configuration in doctrine.yaml

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


Add the repository services Services.yaml

```yaml
services:
    parthenon.tenant.repository:
        class: Parthenon\MultiTenancy\Repository\TenantRepository
        arguments:
            - '@App\Repository\Orm\TenantRepository'
    Parthenon\MultiTenancy\Repository\TenantRepositoryInterface: '@parthenon.tenant.repository'
```

And finally enable in the parthenon config

```yaml
parthenon:
  multi_tenancy:
    enabled: true
    background_creation: false
    domain: ha-local.xyz
    migrations:
      directory: '%kernel.project_dir%/multi_tenancy_migrations'
    doctrine:
      global_dbal_connection: default
      dbal_connection: tenant
      orm_entity_manager: tenant
      default_database: default_database
```

# Dev Env

Update the `docker/database/init.sql`

```sql
CREATE DATABASE parthenon_test;
GRANT ALL PRIVILEGES ON DATABASE parthenon_test TO appuser;
CREATE DATABASE parthenon_tenant;
GRANT ALL PRIVILEGES ON DATABASE parthenon_tenant TO appuser;
CREATE DATABASE parthenon_tenant_test;
GRANT ALL PRIVILEGES ON DATABASE parthenon_tenant_test TO appuser;
```
