---
title: "Gdpr"
date: 2020-10-02T18:41:40+02:00
draft: false
---
GDPR is an European Union law that provides EU cizitens certain rights when it comes to their data. Here we provide some of the things required by GDPR.

## Right to deletion

GDPR provides the right to deletion. A system often has multiple things that need deleted to help orginise and ensure all the data that needs deleted is deleted parthenon provides a `DeleterInterface`

```php
namespace Parthenon\User\Gdpr\Deletion;

interface DeleterInterface
{
    public function delete(UserInterface $user);
}
```

There are cases where data should not be deleted even if the User requests it due to other legal requirements. To help avoiding a case of a user's information being deleted while still being required for a legal reason parthenon provides a `VoterInterface`. parthenon will loop through all Voters and if one returns false then it will not proceed with the deletion.

```php
namespace Parthenon\User\Gdpr\Deletion;

use Parthenon\User\Entity\UserInterface;

interface VoterInterface
{
    public function canDelete(UserInterface $user): bool;
}
```

## Right to export

GDPR provides the right to a machine readable export. As your system grows you'll need to add more and more things to your export file. So we created the `ExporterInterface`. This has a name that will be used as an array key in the overall data export to identify what data it is.



```php
namespace Parthenon\User\Gdpr\Export;

use Parthenon\User\Entity\UserInterface;

interface ExporterInterface
{
    public function getName(): string;

    public function export(UserInterface $user): array;
}
```

Once you have exported the data you need to convert it to a format to give to the user. By default Parthenon ships with a JSON formatter but maybe you have some other requirements or desires.

| Method Name | Arguments | Return | Description |
| --- | --- | --- | --- |
| getName | n/a | string | It returns the name of the formatter. This is is checked with what is defined in the config as the formatter |
| getFilename | UserInterface | string | This returns the name of the export file. It takes the User incase you want to create a user speicific filename |
| format | array | string | The output of the formatter. It takes the data as an array and returns it in the format needed as a string |

```php
namespace Parthenon\User\Gdpr\Export;

use Parthenon\User\Entity\UserInterface;

interface FormatterInterface
{
    public function getName(): string;

    public function getFilename(UserInterface $user): string;

    public function format(array $data): string;
}
```

#### Creating exports

By fetching the service `Parthenon\User\Gdpr\Export\ExportExecutorInterface` you'll be able to generate a Symfony Response that will contain the export data and force the browser to download the file using the filename provided by the formatter.

```php
interface ExportExecutorInterface
{
    public function export(UserInterface $user): Response;
}
```

### Config Example

```yaml
user:
  gdpr:
    export:
      formatter_type: json
```
