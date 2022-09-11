---


---

Create Repository

```php
<?php

namespace App\Repository\Orm;

use Doctrine\Persistence\ManagerRegistry;
use Parthenon\AbTesting\Entity\Experiment;
use Parthenon\Common\Repository\CustomServiceRepository;

class ExperimentRepository extends CustomServiceRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Experiment::class);
    }
}
```

Add to the services.

```yaml
services:
  Parthenon\AbTesting\Repository\ExperimentRepositoryInterface: '@Parthenon\AbTesting\Repository\ExperimentRepository'
  Parthenon\AbTesting\Repository\ExperimentRepository:
      arguments:
          $entityRepository: '@app.repository.orm.experiment'
  app.repository.orm.experiment:
      class: App\Repository\Orm\ExperimentRepository
  Doctrine\DBAL\Connection:
      factory:      Doctrine\DBAL\DriverManager::getConnection
      arguments:
        $params:
          driver:   pdo_pgsql
          url:      '%env(TIMESCALE_URL)%'
          charset:  UTF8
  Redis:
    class: Redis
    calls:
      - connect: ['%env(REDIS_HOST)%']    
```

Add to configuration

```yaml
parthenon:
  ab_testing:
    enabled: true
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

update the routes.yaml

```yaml
parthenon_ab_testing_controllers:
    resource: ../../src/Parthenon/AbTesting/Controller/
    type: annotation
```


## Development features_navlink

Add to docker-composer.yaml

```yaml

// ..
  redis:
    image: redis:4-alpine
    networks:
      - parthenon
    ports:
      - "6379:6379"

  timescaledb:
    image: timescale/timescaledb:latest-pg12
    environment:
      - POSTGRES_DB=${PSQGL_DATABASE_NAME}
      - POSTGRES_USER=${PSQGL_DATABASE_USER}
      - POSTGRES_PASSWORD=${PSQGL_DATABASE_PASSWORD}
    ports:
      - "5432:5432"
    volumes:
      - ./timescaledb/entrypoint.sh:/docker-entrypoint-initdb.d/entrypoint.sh
      - ./timescaledb/data:/var/lib/postgresql/data
    networks:
      - parthenon
```
