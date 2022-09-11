---
title: "Create a Successhandler"
date: 2020-08-25T20:24:04+02:00
draft: false
---
The SuccessHandler is the code that is to be executed upon the successful completion of the funnel. For example, for creating the user account

| Name | Type | Description |
| --- | --- | --- |
| entity | object | The entity that is to be populated by the funnel. |

## RepositoryAwareInterface

If the successHandler implements the RepositoryAwareInterface interface then the repository will automatically be injected into it during the runtime. This will allow you to save the entity.


## Example Code

```php
class SuccessHandler implements SuccessHandlerInterface, RepositoryAwareInterface
{
    private UrlGeneratorInterface $urlGenerator;

    private RepositoryInterface $repository;

    public function __construct(UrlGeneratorInterface $urlGenerator)
    {
        $this->urlGenerator = $urlGenerator;
    }


    public function setRepository(RepositoryInterface $repository): self {
        $this->repository = $repository;

        return $this;
    }

    public function handleSuccess($entity)
    {
        $this->repository->save($entity);
        return new RedirectResponse($this->urlGenerator->generate('app_request_demo_requested'));
    }
}
```
