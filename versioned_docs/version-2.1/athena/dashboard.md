---
title: "Athena Dashboard"
sidebar_label: "Dashboard"
date: 2020-08-26T19:43:24+02:00
draft: false
---
Having a nice dashboard when you log in to Athena can be extremely helpful. Everyone wants to have a cool dashboard.

![](/images/athena/dashboard/default.png)

To create a section you need to create a class that extends `Parthenon\Athena\AbstractDashboardSection`.

## Methods

A dashboard section has a few methods that define what is going to be displayed on the dashboard.

### getTitle

This provides the title that will be displayed. This title is ran through the translation system so you can put a translation id.

### getTemplate

This provides the location of the template file. Athena uses twig to display the site, so you need to use a twig template.

### getTemplateData

This provides the variable data for the twig template. This allows you to put in dynamic data.

### getColumnSize

This allows you to define how wide the section is. Athena uses the css bootstrap framework and the grid system is being used. The size of a column can range from 1 to 12. 12 is the entire width and 1 is 1/12 of the entire width.

### getPriority

This defines what order the section should be. The lower the priority then the higher it is shown. So `-1` will be shown before `0` and `10` afer `5`.

### isEnabled

This defines if the section should be displayed. `true` means it is to be shown and `false` means it should not be shown.

## Example Code

```php
<?php

declare(strict_types=1);

namespace App\Athena\Dashboard;

use Parthenon\Athena\AbstractDashboardSection;
use Parthenon\User\Repository\UserRepositoryInterface;

final class Example extends AbstractDashboardSection
{
    public function __construct(private UserRepositoryInterface $userRepository)
    {
    }

    public function getTitle(): string
    {
        return 'parthenon.user.athena.dashboard.signup_stats.title';
    }

    public function getTemplate(): string
    {
        return 'athena/dashboard/example-section.html.twig';
    }

    public function getTemplateData(): array
    {
        return ['variableName' => 'variable value'];
    }

    public function getColumnSize(): int
    {
        return 12;
    }

    public function getPriority(): int
    {
        return 1;
    }

    public function isEnabled(): bool{
        return true;
    }
}
```
