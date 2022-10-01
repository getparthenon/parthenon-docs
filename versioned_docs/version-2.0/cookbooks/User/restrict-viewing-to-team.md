---
title: "Restrict viewing item to team members"
date: 2020-08-25T20:18:40+02:00
draft: false
---
Once you've created a team application you need to be able to restrict the ability for people to view an item based on if they're a member of the team. Parthenon provides this functionality out-of-the-box.

### Step 1 add the interface TeamOwnedInterface to your entity

```php
<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use Parthenon\User\Entity\TeamInterface;
use Parthenon\User\Entity\TeamOwnedInterface;

/**
 * @ORM\Entity()
 * @ORM\Table(name="alerts")
 */
class Alert implements TeamOwnedInterface
{
    // ...


    /**
     * @ORM\ManyToOne (targetEntity="Parthenon\User\Entity\TeamInterface")
     */
    protected TeamInterface $team;

    public function getTeam(): TeamInterface
    {
        return $this->team;
    }

    public function setTeam(TeamInterface $team): void
    {
        $this->team = $team;
    }

    public function getOwningTeam(): TeamInterface
    {
        return $this->getTeam();
    }
}
```

### Step 2 - Check in controller if allowed

```php

use App\Repository\AlertRepositoryInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\Authorization\AuthorizationCheckerInterface;

class AlertController
{
  #[Route('/api/alerts/{id}', name: 'app_api_alerts_id_get', methods: ['GET'])]
  public function viewAlert(Request $request, AlertRepositoryInterface $alertRepository, AuthorizationCheckerInterface $authorizationChecker, )
  {
    $alert = $alertRepository->findById($request->get('id'));

    if (!$authorizationChecker->isGranted('view', $alert)) {
        throw new NotFoundHttpException();
    }
    // ...  
  }
}
```
