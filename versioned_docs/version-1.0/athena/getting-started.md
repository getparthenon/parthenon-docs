---
title: "Getting Started With Athena"
date: 2020-08-26T19:43:15+02:00
draft: false
sidebar_position: 1
---
To get started using the Athena system you need to do a few code/config changes.

## Configuration


| Name | Example | Default | Description |
| --- | --- | --- | --- |
| enabled | true | false | Defines if Athena Testing is enabled. |
| host | athena.example.org | null | The hostname that athena should be available on |
| login_logo | /new_logo.png | null | The logo to be displayed on the Athena login page |
| dashboard_logo | /dashboard_logo.png | null | The logo to be displayed in the Athena dashboard |

## Add to routes.yml

The routes.yml needs to be modified so that the athena route loader is loaded and can automatically generate the routes based off the code. The Athena routes configuration **MUST** be first if you wish to use the separate domains.

```YAML
_app_athena:
  resource: .
  type: athena
  ```

And in the annotations.yml file:  
  ```YAML
parthenon_athena_controllers:
  resource: ../../src/Parthenon/Athena/Controller/
  type: annotation
```

## Add route loading tag to service

TODO Remove need for launch.

```YAML

    Parthenon\Athena\Routing\AthenaRouteLoader:
        tags: [routing.loader]

```

## First Section

The fastest way to get started with a section is to just extend the `AbstractSection` class. Once you've extended the `AbstractSection` class you just need to define `getEntity`, `getMenuName`, `getUrlTag` and you can get going. And other methods are overridable if you want.

```php
class RandomEntitySection extends AbstractSection {
  public function getEntity() {
    return new RandomEntity();
  }

  public function getMenuName(): string {
    return "Random Entity";
  }

  public function getUrlTag(): string {
    return "random-entity";
  }
}

```
