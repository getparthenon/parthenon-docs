---
title: "HTTP Client"
date: 2020-09-26T20:29:24+02:00
draft: false
---
This is the abstraction of HTTP requests that is used throughout the Parthenon system. With this abstraction you'll be able to quickly and easily send HTTP requests in your application.

## Concept
In order to build a robust flexible system we advise avoiding coupling directly to a specific version of a HTTP client. As a system ages you often build out and build sub systems and share core libaries. It happens quite often that one system will be using one version of a library and others are using another version. This can cause major headaches if your library is coupled to a specific version of Guzzle.

{{% notice info %}}
Currently only Guzzle is supported however more clients will be added later.
{{% /notice %}}
## Autowiring

To allow for autowiring Parthenon has a factory service to create new HttpClients. You just need to typehint the `\Parthenon\Common\Http\ClientInterface` interface and a HTTP client will be injected.


## Interface

The Parthenon http client interface extends the PSR-7 `ClientInterface`. This allows you to create requests using the PSR-7 `RequestInterface`


```php
/*
 * Copyright Iain Cambridge 2020, all rights reserved.
 */

namespace Parthenon\Common\Http;

use Psr\Http\Client\ClientInterface as PsrClientInterface;
use Psr\Http\Message\RequestInterface;
use Psr\Http\Message\ResponseInterface;

interface ClientInterface extends PsrClientInterface
{
    public function sendRequest(RequestInterface $request, array $options = []): ResponseInterface;
}
```
