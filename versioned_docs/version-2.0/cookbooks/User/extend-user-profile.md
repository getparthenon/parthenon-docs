---
title: "Extend User Profile"
date: 2020-08-25T20:18:40+02:00
draft: false
---
To add fields to the user profile you first need to extend the user entity and add the fields there then extend the profile form type. And then override the profile form type service.



```php
<?php

namespace App\Form\Type;

use Parthenon\User\Form\Type\ProfileType as BaseProfileType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;

class ProfileType extends BaseProfileType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        parent::buildForm($builder, $options);
        $builder->add('vat_number', TextType::class, ['label' => 'app.user.profile.vat_number']);
    }
}
```

and add to services

```yaml
services:
    Parthenon\User\Form\Type\ProfileType: '@App\Form\Type\ProfileType'
```