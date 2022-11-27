---
title: "Repositories"
date: 2020-08-25T20:17:44+02:00
draft: false
---
The Repositories are based on the repository pattern. They're basically classes where you should keep all of your database logic. They should be split up by entities, so for every entity, it is normal to have a repository just for that entity. This allows you to have to look at only one place for your database logic for an entity.

Within Parthenon, these repositories are defined as interfaces and then have a class implementing that interface. The reason for defining an interface is to allow your development team to be able to change the source of data for a specific entity or to have multiple implementations for a repository. Even if you never need to change something having the ability to do so gives you options that if you didn't have the ability wouldn't be available.

## Why would the data source change?

As companies grow so does their software, here are some of the reasons a data source might change in the future:

* It is not uncommon for a development team to want to start migrating data from their monolith to come from a microservice.
* When an application grows the data grows and what was performant for a few thousand records may not be performant for a few million. It's possible that you start with one database and then find for some data another database will allow your company to scale better. When all you need to do on a code level is reimplement an interface this technical decision becomes a lot easier and cheaper.

## Why would I have multiple implementations for a repository

Using an ORM such as Doctrine is extremely common, however, it is not the best solution for a lot of things. In fact, their own [documentation](https://www.doctrine-project.org/projects/doctrine-orm/en/2.7/reference/limitations-and-known-issues.html) will tell you so. So for some cases using Doctrine may be good enough to get the job done but in other cases, you may want to switch over to using PDO directly and writing SQL queries. If you have an interface then you can easily do this.

The default repository contains just a `save` message.

```php
interface RepositoryInterface
{
    public function save($entity);
}
```

## Doctrine 
Out of the box, parthenon provides Doctrine abilities. The Doctrine classes that parthenon uses and advises are different from the standard Doctrine repositories. This is to enforce the fact that all the doctrine functionality is kept within the repository. If doctrine functionality leaks out of the repository class and can be used directly it is possible for code to be using doctrine functionality that isn't defined within the interface and would **remove** the flexibility that the repositories are meant to provide. The thought pattern is, if it's available to be used, someone will eventually use it.

Considering the way that the parthenon Doctrine repositories are designed there is a tiny amount of configuration work when adding in a new repository. However, it is felt that this initial work is outweighed by the benefits of having a flexible system that provides the development team with future options.

How the parthenon doctrine is designed is that you inject the Doctrine repository object into a wrapper class and then that repository object is available within the wrapper class and you can write code just as you normally would within a Doctrine repository while preventing accidental leakage.

The first step is to use the `CustomServiceRepository` that comes with Doctrine.

```php
namespace App\Repository\Doctrine;

class OrderRepository extends CustomServiceRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Order::class);
    }
}
```

Then create your interface

```php
namespace App\Repository;
use Parthenon\Common\Repository\RepositoryInterface;

interface OrderRepositoryInterface extends RepositoryInterface
{
    public function findActiveByCode($code): Order;
}
```

Then create your repository class that extends the parthenon Doctrine repository and implements your own Repository interface.

```php
namespace App\Repository;

use App\Entity\Order;
use Parthenon\Common\Exception\NoEntityFoundException;
use Parthenon\Common\Repository\DoctrineRepository;

class OrderRepository extends DoctrineRepository implements OrderRepositoryInterface
{
    public function findActiveByCode($code): Order
    {
        $order = $this->entityRepository->findOneBy(['code' => $code]);

        if (!$order) {
            throw new NoEntityFoundException();
        }

        return $order;
    }
}

```

And in your service.yml define that the interface uses the OrderRepository with the doctrine repository being injected into it.

```yaml
App\Repository\OrderRepositoryInterface:
        class: App\Repository\OrderRepository
        arguments:
            - '@App\Repository\Doctrine\OrderRepository'
```
