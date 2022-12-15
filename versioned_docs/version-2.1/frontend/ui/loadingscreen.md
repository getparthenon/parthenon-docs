---
title: "Frontend - UI - LoadingScreen"
sidebar_label: "LoadingScreen"
date: 2020-09-04T17:30:32+02:00
draft: false
sidebar_position: 2
---
Often you'll want to wait until you've fetched the data from the server before displaying the page, this component provides a fast and quick way to insert a loading screen while you wait for the data to be returned.

### Props

| Name | Data Type | Default | Description |
| --- | --- | --- | --- |
| ready | boolean | n/a | If the page is loaded or not |
| loadingSpinnerColor | string | `black` | The colour of the spinner |
| loadingClass | string | `loading-message` | The class assigned to the div that contains the loading message |
| loadingMessage | string | `Loading` | The text to be displayed with the loading |

## Slots

There are two slots, the `default` slot and `loading` slot.

The `loading` slot is optional and contains `LoadingMessage` by default.

### Example

```jsx
<LoadingScreen :ready="loaded" loading-message="Loading message">
  <p>Content</p>
</LoadingScreen>
```
