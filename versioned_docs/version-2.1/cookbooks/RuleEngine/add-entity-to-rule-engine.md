---
title: "Add Entity To Rule Engine"
date: 2020-08-25T20:18:40+02:00
draft: false
---
To add an entity to the rule engine you need to add the repository.

```php
use Parthenon\Athena\Repository\DoctrineCrudRepository;
use Parthenon\RuleEngine\Repository\RuleEngineRepositoryInterface;

class DemoRequestRepostiory extends DoctrineCrudRepository implements RuleEntityRepository
{
  public public function getEntity()
  {
    return new DemoRequest();
  }
}
```

Then you'll see DemoRequest in the list for the Rule Engine
