---
title: "Elasticsearch"
date: 2020-09-26T20:29:24+02:00
draft: false
---
Here we provide the elasticserach docs.

## ClientInterface


```PHP
<?php

declare(strict_types=1);

/*
 * Copyright Iain Cambridge 2020-2021, all rights reserved.
 */

namespace Parthenon\Common\Elasticsearch;

interface ClientInterface
{
    public function save(string $indexName, array $body);

    public function search(string $indexName, array $query): array;

    public function delete(string $indexName, string|int $id): array;
}
```
