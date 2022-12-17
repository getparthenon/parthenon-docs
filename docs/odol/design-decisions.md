---
title: "Odol - Design Decisions"
sidebar_label: "Design Decisions"
date: 2020-09-04T17:30:32+02:00
draft: false
sidebar_position: 3
---
Here are the design decisions made for Obol.

## Standalone library

I decided to make this a standalone library so that it could be used by itself. It aims to provide extremely useful functionality which should be able to be useful in any PHP application handling payments.

## Models aren't final

The reason Models aren't final classes is that they should be extendable to add extra fields if needed. If extra fields are added custom data mappers would also be required.
