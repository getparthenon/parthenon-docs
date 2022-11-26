---
title: "Export - Design Decisions"
sidebar_label: "Design Decisions"
date: 2020-08-26T19:43:24+02:00
draft: false
---

## ExportRequest

### DataProviderService

The ExportRequest has a string field which defines which service is to be used to provide the data for the export request.

Originally, the idea was to use a closure that would provide the data; however it would run into issues when executing the request in the background unless the data was fetched in the original request and part of the reason for using a background is that the fetch retrieval can be be expensive. To make use of the Symfony services, it's better if the background process is using a service.

There were two ideas. The other was creating a `supports` method and looping through the available data providers and seeing if that `ExportRequest` was supported. This would either result in separate classes created for each export type which could become annoying and more importantly, create complex fragile `supports` methods.

Instead, we define the service that is to be used to fetch the data. This allows using the same `ExportRequest` class, isolating the logic for the data retrieval, and using Symfony services correctly.

:::note

The downside of this approach is that the DataProvider service must be made public. This is done automatically by the compiler pass.

:::

## DataProviderInterface

Once using closures were not going to be used for data providing. An interface was needed.

The reason it returns `iterable` is to allow you to use either an array, an object implement `Traversable`, or a generator. Thus providing the maximum flexibility.

## ResponseConverter


Originally, the idea was that each response class would contain the logic to convert to a Symfony response. However, this would result in a very rigid response ouput since it would be harder to change the response.

So the approach taken was to create ResponseConverter to convert ExportResponseInterface instances to Symfony responses was made to allow the ability to have very custom responses to be extremely easy. This way all people need to do is create an implementation of ResponseConverterInterface and overridden the default alias.
