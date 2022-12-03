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
| enabled | true | no | This shows if the export module is enabled |
| engine | direct_download | no | To configure which export engine is enabled |



## Export Engines

### Direct Download

For simple and small exports providing an export straight away within the original request is the best way to go.

### Background Download

For large exports you want to generate the export in the background and only allow the user to download it once it's been generated.

### Background Email

There are cases where you will want to just send the export to someone via email.

### Create Your Own

To create your own export engine, you need to create a class that implements `Partheon\Export\Engine\EnginerInterface`.
