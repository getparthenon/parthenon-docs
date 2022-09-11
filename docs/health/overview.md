---
title: "Health - Overview"
date: 2020-08-31T17:23:09+02:00
draft: false
sidebar_label: "Overview"
---
Parthenon comes with various tools to help your monitor the health of your application.

## Health Check endpoint
The healthcheck is an endpoint that provides the ability for services to check the health of a server. The uses can be for an uptime monitoring service or a cloud service to ensure a node is still health and available for traffic.

Some of of the things that companies may want to have checked for their health:

* Filesystem available space - if there is little to no Filesystem space left.
* Database connection
* Queue size - If too many items are in the queue.
* Caching availablity

## Endpoint

GET /healthcheck

## Output

The healthcheck endpoint will return a json response. The status code will be 200 if the endpoint is healthy or 500 if it is not. The healthcheck endpoint will go through all the checks the system has and if one returns false then the node will be considered unhealthy.

```json
{
  "isHealthy":true,
  "checks":{
    "doctrine":true
  }
}
```

## Checks

To implement your own healthcheck you need to implement the `CheckInterface`

### Methods

| Method Name | Return Type | Description |
| --- | --- | --- |
| getName | string | The name of the healthcheck. It will be returned in the healthcheck endpoint. |
| getLevel | string | The level of severity for the healthcheck. Some issues may be major issue and should be reported in the downtime as a major issue and others may be minor with a degraded performance. |
| getStatus | boolean | True or false value of the healthcheck. Is health or not |


### Example

```php

namespace Parthenon\Health\Checks;

use Doctrine\ORM\EntityManagerInterface;

class DoctrineConnectionCheck implements CheckInterface
{
    private const NAME = 'doctrine';

    private EntityManagerInterface $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    public function getName(): string
    {
        return self::NAME;
    }

    public function getStatus(): bool
    {
        try {
            $connection = $this->entityManager->getConnection();

            if (!$connection->isConnected()) {
                if (!$connection->connect()) {
                    return false;
                }
            }

            return true;
        } catch (\Throwable $e) {
            return false;
        }
    }

    public function getLevel(): string
    {
        return CheckInterface::LEVEL_CRITICAL;
    }
}
```
