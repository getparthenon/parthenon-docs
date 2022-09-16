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

## LoadingScreen

Often you'll want to wait until you've fetched the data from the server before displaying the page, this component provides a fast and quick way to insert a loading screen while you wait for the data to be returned.

### Props

| Name | Data Type | Default | Description |
| --- | --- | --- | --- |
| ready | boolean | n/a | If the page is loaded or not |
| loadingSpinnerColor | string | `black` | The colour of the spinner |

### Example

```jsx
<LoadingScreen :ready="loaded">
  <template v-slot:content>
    <p>Content</p>
  </template>
  <template v-slot:message>Loading message</template>
</LoadingScreen>
```
