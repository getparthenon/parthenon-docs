---
title: "Enable RuleEngine"
date: 2020-08-25T20:18:40+02:00
draft: false
---
To enable the Rule Engine you need to do the following

Enable in Parthenon config.

```yaml
parthenon:
  // ...
  rule_engine:
    true
```

Add to routes config

```YAML
parthenon_rule_engine_controllers:
    resource: ../../vendor/Parthenon/RuleEngine/Controller/
    type: annotation
```    

Create a ORM Repository for `Rule` and `RuleExecutionLog`.

```php
<?php

namespace App\Repository\Orm;

use Doctrine\Persistence\ManagerRegistry;
use Parthenon\Common\Repository\CustomServiceRepository;
use Parthenon\RuleEngine\Entity\Rule;

class RuleRepository extends CustomServiceRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Rule::class);
    }
}
```

```php
<?php

namespace App\Repository\Orm;

use Doctrine\Persistence\ManagerRegistry;
use Parthenon\Common\Repository\CustomServiceRepository;
use Parthenon\RuleEngine\Entity\RuleExecutionLog;

class RuleExecutionLogRepository extends CustomServiceRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RuleExecutionLog::class);
    }
}
```

And then add to services.yaml

```yaml
services:
  // ....
  Parthenon\RuleEngine\Repository\RuleRepositoryInterface: '@parthenon.rule_engine.repository.rule'
  parthenon.rule_engine.repository.rule:
      class: Parthenon\RuleEngine\Repository\RuleEngineRepository
      arguments:
          - '@App\Repository\Orm\RuleRepository'


  Parthenon\RuleEngine\Repository\RuleExecutionLogRepositoryInterface: '@parthenon.rule_engine.repository.rule_log_execution'

  parthenon.rule_engine.repository.rule_log_execution:
      class: Parthenon\RuleEngine\Repository\RuleExecutionLogRepository
      arguments:
          - '@App\Repository\Orm\RuleExecutionLogRepository'
```
