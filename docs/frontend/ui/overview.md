---
title: "Frontend - UI - Overview"
sidebar_label: "Overview"
date: 2020-09-04T17:30:32+02:00
draft: false
sidebar_position: 1
---
The UI package that comes with Parthenon is designed to help you quickly and easily build you're User Interface by providing components that provide beautiful and sleeky UI components.

## LoadingMessage

Often throughout your application you'll want to display a message while something is loading. The `LoadingMessage` component provides a spinning circle SVG with customisable text next to it.

### Props

| Name | Data Type | Default | Description |
| --- | --- | --- | --- |
| height | string | `20px` | The height of the spinner |
| color | string | `rgb(255 255 255 / var(--tw-text-opacity))` | The colour of the spinner |

### Example

```jsx
<LoadingMessage>Loading</LoadingMessage>
```
