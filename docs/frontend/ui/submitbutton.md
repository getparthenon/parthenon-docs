---
title: "Frontend - UI - SubmitButton"
sidebar_label: "SubmitButton"
date: 2020-09-04T17:30:32+02:00
draft: false
sidebar_position: 1
---
Creating a submit button that changes while the form is being submitted creates an easy to understand user interface that the form is being processed and prevents double clicks.

## Props

| Name | Data Type | Default | Description |
| --- | --- | --- | --- |
| button-class | string | `btn--main` | The css class for the button |
| in-progress | bool | n/a | If the submission is in progress |
| loading-text | string | `In Progress` | The text to be shown while in progress |

## Slots

There are two slots, the `default` slot and `loading` slot.

The `loading` slot is optional and contains `LoadingMessage` by default.

## Example

```jsx
<SubmitButton :in-progress="submitting">Save</SubmitButton>

<SubmitButton loading-text="Saving">Save</SubmitButton>

<SubmitButton>
  <template v-slot:default>Submit</template>
  <template v-slot:loading>Submitting</template>
</SubmitButton>
```
