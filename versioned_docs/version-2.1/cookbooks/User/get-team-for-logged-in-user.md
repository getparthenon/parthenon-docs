---
title: "Get Team For Logged In User"
date: 2020-08-25T20:18:40+02:00
draft: false
---
To get the team for the logged in user you can use the `CurrentTeamProvider`.

```php

use Parthenon\User\Team\CurrentTeamProviderInterface;


class ExampleController
{
  public function action(CurrentTeamProviderInterface $currentTeamProvider)
  {
    $team = $currentTeamProvider->getCurrentTeam();


    return new Response('hello world');
  }
}
```
