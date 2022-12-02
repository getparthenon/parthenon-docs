---
title: "Athena - Design Decisions"
sidebar_label: "Design Decisions"
date: 2020-08-26T19:43:24+02:00
draft: false
---


## AthenaRouteLoader

The reason that there is a custom router loader class for Athena is for two reasons:

1. To allow for the generation of dynamic routes from the Athena Sections.
2. To allow for the addition of the custom host when Athena is to be hosted on a separate hostname. This allows the parameter that holds this value to be null, where if it was just a parameter it would always need to be defined.
