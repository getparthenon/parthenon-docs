---
title: "Export - Overview"
date: 2020-08-26T19:43:15+02:00
draft: false
sidebar_position: 1
sidebar_label: "Overview"
---
Data export is an important feature for many applications. It is also a source of technical debt and minor outages for many technical teams. To solve this issue, Parthenon provides a robust Export system that can handle all scales.

## Configuration

| Name | Example | Required | Description |
| --- | --- | --- | --- |
| `enabled` | `true` | no | This shows if the export module is enabled |
| `default_engine` | direct_download | no | To configure which export engine is linked to `Parthenon\Export\Engine\EngineInterface`. Options: `direct_download`, `background_download`, `background_email` |
| `user_provider` |  | no | The service id for the user provider, used by the background email engine. |

## Export Request

The class `Parthenon\Export\ExportRequest`.

Fields:

| Name | Type | Description |
| --- | --- | --- |
| `name` | `string` | The name for export |
| `exportFormat` | `string` | The format for the export. This is used to find the correct `Exporter`. This should match the value from `ExporterInterface::getFormat`. |
| `dataProviderService` | `string` | The service id for the data provider. |
| `dataProviderParameters` | `array` | The parameters to be passed to the data provider |


## Export Engines

You can include the export engines either by injecting `Parthenon\Export\Engine\EngineInterface` which is an alias to the engine defined in the configuration. Or by injecting the specific export engine you want to use.

### Direct Download

For simple and small exports providing an export straight away within the original request is the best way to go.

**Service Id:** `Parthenon\Export\Engine\DirectDownloadEngine`
**Configuration Name:** `direct_download`

### Background Download

For large exports you want to generate the export in the background and only allow the user to download it once it's been generated.

**Service Id:** `Parthenon\Export\Engine\BackgroundDownloadEngine`
**Configuration Name:** `background_download`

### Background Email

There are cases where you will want to just send the export to someone via email.

**Service Id:** `Parthenon\Export\Engine\BackgroundEmailEngine`
**Configuration Name:** `background_email`

### Create Your Own

To create your own export engine, you need to create a class that implements `Partheon\Export\Engine\EngineInterface`.

## Exporters

Exporters implement the `Parthenon\Export\Exporter\ExporterInterface` interface. All services that implement this interface are tagged by the compiler pass and then added to the `ExporterManager`.

This means you can easy add your own Exporter and have it working within the export system without a lot of hassle of configuring things. Just create a class and register a service. The second requirement only exists if you're not using autowiring in your app.

### Built-in Exporters

Parthenon comes with export formats supported by default.

These are:

* Comma Separated Values aka `csv`
* Excel spreedsheets aka `xlsx`

## Normalisers

Converting the data from how it is internally to what is required for an export file is done in what is called Normalisers.

To create your own Normaliser you need to create a class that implements the `Parthenon\Export\Normaliser\NormaliserInterface`. All services implementing the `NormaliserInterface` will be tagged and collected and added to the `NormaliserManager`.

## DataProvider

For any export you'll need to define a data provider. In order to fully work while sending requests to be processed in the background, the data provider must be a registered as a service.

```php
<?php

namespace Parthenon\Export\DataProvider;

use Parthenon\Export\Exception\DataProviderFailureException;
use Parthenon\Export\Exception\InvalidDataProviderParameterException;
use Parthenon\Export\ExportRequest;

interface DataProviderInterface
{
    /**
     * @throws InvalidDataProviderParameterException
     * @throws DataProviderFailureException
     */
    public function getData(ExportRequest $exportRequest): iterable;
}
```

## ResponseConverter

An easy way to allow for multiple export engines to be used within the same application and be toogable the response converter is where you can encapsulate the logic.

```php
<?php

declare(strict_types=1);

namespace Parthenon\Export\Response;

use Parthenon\Export\Exception\UnsupportedResponseTypeException;
use Parthenon\Export\ExportResponseInterface;
use Symfony\Component\HttpFoundation\Response;

interface ResponseConverterInterface
{
    /**
     * @throws UnsupportedResponseTypeException
     */
    public function convert(ExportResponseInterface $exportResponse): Response;
}

```

This is optional.

## Example Usage

Here is an example usage.

### Example Controller

```php
namespace Parthenon\Athena\Crud;

use Parthenon\Athena\Export\DefaultDataProvider;
use Parthenon\Export\Engine\EngineInterface;
use Parthenon\Export\Exporter\ExporterManagerInterface;
use Parthenon\Export\Exporter\ExporterManagerInterface;
use Parthenon\Export\Response\ResponseConverterInterface;

class CrudController
{
    public function export(Request $request, EngineInterface $engine, ResponseConverterInterface $responseConverter)
    {
        $exportName = $request->get("name");
        $exportFormat = $request->get("format");

        $exportRequest = new ExportRequest($exportName, $exportFormat, DefaultDataProvider::class, $parameters);

        $response = $engine->process($exportRequest);

        return $responseConverter->convert($response);
    }
}
```

### DataProvider Example

```php
<?php

namespace App\Export;

use Parthenon\Export\DataProvider\DataProviderInterface;

class DemoDataProvider extends DataProviderInterface
{
    public function __construct(
        private DemoDataRepositoryInterface $repository,
    ) {
    }

    public function getData(ExportRequest $exportRequest): iterable
    {
        return $this->repository->findAll();
    }
}
```
