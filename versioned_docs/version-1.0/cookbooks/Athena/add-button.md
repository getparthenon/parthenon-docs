---
title: "Adding a button"
date: 2020-08-25T20:18:40+02:00
draft: false
---
For whatever reason you may decide that you need to add another action to one of your Athena sections. Here is the simple way to do this

:::important

The path will have the parameter "id" that will accept the id of the entity that the section is for.
:::
```php
<?php

namespace App\Athena;

use Parthenon\Athena\Button;
use Parthenon\Athena\ReadView;

class UserSection extends \Parthenon\User\Athena\UserSection
{
    public function getButtons(): array
    {
        return [
            new Button(
                name:'parthenon_athena_user_redirect',
                label: 'Redirect back',
                path: 'athena_user_redirect'
            ),
        ];
    }
}
```

## Handle redirect to section

To redirect back to the Athena read page you need to generate aurl to the path `pathernon_athena_crud_{$sectionName}_read` with the url parameter `id` for the id of the entity.

```php
<?php

namespace App\Controller\Athena;

use App\Repository\UserRepositoryInterface;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;

class RedirectController
{
    #[Route("/athena/user/{id}/redirect", name: 'athena_user_redirect')]
    public function togglePackagist(Request $request, UrlGeneratorInterface $urlGenerator, UserRepositoryInterface $userRepository)
    {
        // Do your logic here.

        return new RedirectResponse($urlGenerator->generate('parthenon_athena_crud_user_read', ['id' => $request->get('id')]));
    }
}
```
