---
title: "Create A Step"
date: 2020-08-25T18:59:34+02:00
draft: false
---
To build a funnel you need to define the elements of your funnel. To do that you implemnt the `ElementInterface`. This will contain all the logic for that element of your funnel. It has two methods `isComplete` and `getOutput`. The `isComplete` method is used to define if that element has been complete and the user is to move on to the next element in the funnel. With `getOutput` returning the data that is to be used for the output. Because `getOutput` doesn't define a return type you can return whatever you want and have your controller behaving however you would like.


| Name | Type | Description |
| --- | --- | --- |
| request | Request | The symfony HTTP request that is to be processed for the funnel. |
| formFactory | FormFactoryInterface | The Symfony FormFactory to be used to handle the data coming from request. |
| entity | object | The entity that is to be populated by the funnel. |

## RepositoryAwareInterface

If the Step implements the RepositoryAwareInterface interface then the repository will automatically be injected into it during the runtime. This will allow you to save the entity.

{{% notice tip %}}
Don't save the funnel progress into the same database/entity as you would like to keep the successful funnel completions. Otherwise, you will end up filling up your database with half complete entries that will slow down performance of your application and make dealing with the data harder. If possible, keep the funnel progress in a different location.
{{% /notice %}}


## Example Element Code
```php

namespace App\Funnel;

use App\Form\Type\FunnelStepOneType;
use Parthenon\Funnel\ElementInterface;
use Symfony\Component\Form\FormFactoryInterface;
use Symfony\Component\Form\FormInterface;
use Symfony\Component\HttpFoundation\Request;

class StepOne implements ElementInterface
{
    private ?FormInterface $form;

    public function getOutput(Request $request, FormFactoryInterface $formFactory, $entity)
    {
        $form = $this->getFormType($formFactory, $entity);

        return ['form' => $form->createView()];
    }

    public function isComplete(Request $request, FormFactoryInterface $formFactory, $entity): bool
    {
        $form = $this->getFormType($formFactory, $entity);
        if ($request->isMethod('POST')) {
            $form->handleRequest($request);
            if ($form->isSubmitted() && $form->isValid()) {
                return true;
            }
        }

        return false;
    }

    private function getFormType(FormFactoryInterface $formFactory, $entity): FormInterface
    {
        if (!isset($this->form)) {
            $this->form = $formFactory->create(FunnelStepOneType::class, $entity);
        }

        return $this->form;
    }
}

```
