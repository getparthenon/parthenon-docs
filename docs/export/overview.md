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

### Background Download

For large exports you want to generate the export in the background and only allow the user to download it once it's been generated.

**Service Id:** `Parthenon\Export\Engine\BackgroundDownloadEngine`

### Background Email

There are cases where you will want to just send the export to someone via email.

**Service Id:** `Parthenon\Export\Engine\BackgroundEmailEngine`

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



## ResponseFactory
