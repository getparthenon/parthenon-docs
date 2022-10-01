---
title: "Athena - Disable create new entity"
label: "Disable create new entity"
date: 2020-08-25T20:18:40+02:00
draft: false
---
When building a system, you can end up with data that you want to be only created by users but managable by Athena users. In this case you can disable the create functionality.

```php
class DemoSection extends AbstractSection
{
   // ...

  public function getSettings(): Settings
  {
    return new Settings(['create' => false]);
  }   
}
```
