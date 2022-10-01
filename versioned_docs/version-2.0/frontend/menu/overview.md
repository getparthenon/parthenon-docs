---
title: "Frontend - Menu - Overview"
sidebar_label: "Overview"
date: 2020-09-04T17:30:32+02:00
draft: false
sidebar_position: 1
---
The menu package that comes with Parthenon is designed to help you quickly build a powerful and easy to use menu.

## Components

* Menu
* MenuGroup
* MenuItem

## Menu

### Props

| Name | Type | Default Value | Description |
| --- | --- | --- | --- |
| `list-class` | `String` or `Object` | `menu-list` | The class that is provided to the ul list |


### Example

```vue
<Menu>
  <!-- ... Contents of Menu --->
</Menu>
```

### Output

```html
<div>
  <ul class="menu-list">
    <!-- ... Contents of Menu -->
  </ul>
</div>    
```

## MenuGroup

### Props

| Name | Type | Required | Default Value | Description |
| --- | --- | --- | --- | --- |
| `name` | `String` | `true` | n/a |
| `title-class` | `String` or `Object` | `false` | `menu-group-title` | The class that is provided to the div containing the title for the group |
| `list-class` | `String` or `Object` | `false` | `menu-group-list` | The class that is provided to the ul list |


### Example

```vue
<MenuGroup name="Section">
  <!-- ... Contents of Menu --->
</MenuGroup>
```

### Output

```html
<li>
  <div class="menu-group-title">Section</div>
  <ul class="menu-group-list">
    <!-- ... Contents of Menu -->
  </ul>
</li>
```


## MenuItem

### Props

| Name | Type | Required | Default Value | Description |
| --- | --- | --- | --- | --- |
| `route-name` | `String` | `true` | n/a | The name of the vue route the link is for. |
| `route-options` | `Object` | `false` | `{}` | The route options. |
| `link-class` | `String` or `Object` | `false` | `menu-link` | The class that is provided to the link |
| `item-class` | `String` or `Object` | `false` | `menu-item` | The class that is provided to the link |


### Example

```vue
<MenuItem route-name="app.home">Home</MenuItem>
```

### Output

```html
<li class="menu-item">
  <a aria-current="page" href="/app/home" class="router-link-active router-link-exact-active menu-link">Home</a>
</li>
```
