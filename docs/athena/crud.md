---
title: "C.R.U.D."
date: 2020-08-26T19:43:24+02:00
draft: false
---
CRUD (Create. Read. Update. Delete) is one of the basic functionalities that a company requires from their Athena is to maintain data.

* [Create/edit](#createedit)
* [Read](#read)
* [Delete](#delete)
* [List](#list)
* [View Types](#view-types)
* [Filters](#filters)
* [Repository](#repository)
* [Buttons](#buttons)
* [UI](#ui)

## Section
To have CRUD functionality for data you must define a Athena Section. To do this you need to have a class that implements the SectionInterface.

## Create/Edit
The create/edit page is the page that will allow employees to edit the data to keep the data up to date. The view is built of sections and fields. There must be a section for a field to be displayed in. This allows you to have the data grouped to make it easier for your employees to find data to modify.

`section` parameters:

| Name | Type | Description | Example |
| --- | --- | --- | --- |
| name | string | The name of the section. This should be in snake case. | user_information |

`field` parameters:

| Name | Type | Description | Example |
| --- | --- | --- | --- |
| name | string | The name of the field, it must correspond with the entity field otherwise an exception will be thrown. The name **MUST** be in snake case even if the entity has it in camel case. | email |
| type | string | The type of field that should be on the form. This is a snake case value that is related to the Symfony form types. For example, `password` will use the `PassswordType` and `date_time` will use the `DateTimeType`. | text |


### Example Code

```php
class Section implements SectionInterface
{
    // ...
    public function buildEntityForm(EntityForm $entityForm): EntityForm
    {
        $entityForm->section("user_information")
                ->field("name", "text")
                ->field("email", "text")
            ->end();


        return $entityForm;
    }
    // ...
}
```

### Example UI

![UI](/images/crud/edit-ui.png)

## Read

The read page is the page that will allow employees to view the data. The view is built of sections and fields. There must be a section for a field to be displayed in. This allows you to have the data grouped to make it easier for your employees to find data.

`section` parameters:

| Name | Type | Description | Example | Required |
| --- | --- | --- | --- | --- |
| name | string | The name of the section. This should be in snake case. | user_information | true |
| controller | string | The controller that should be rendered in twig | App\Controller\UserController::info | false |

`field` parameters:

| Name | Type | Description | Example | Required |
| --- | --- | --- | --- | --- |
| name | string | The name of the field, it must correspond with the entity field otherwise an exception will be thrown. The name **MUST** be in snake case even if the entity has it in camel case. | email | false |
| type | string | The view type for the field. A valid view type with that name must exist otherwise an exception is thrown. | text | false |
| extraOptions | array | The extra options passed to the Symfony form type | [] | false |
| editable | bool | If the field is editable | true | false |

### Example Code

```php
class Section implements SectionInterface
{
    // ...
    public function buildReadView(ReadView $readView): ReadView
    {
        $readView->section("user_information")
                ->field("name")
                ->field("email")
            ->end()
            ->section("user_permissons")
                ->field("is_admin", "boolean")
            ->end();

        return $readView;
    }
    // ...
}
```

### Example UI

![UI](/images/crud/read-ui.png)

## List

The list page is the page that allows employees to browse and search the data to find the data they wish to manage. This is defined by implementing the buildListView method of the SectionInterface. This allows you to customise how you display the list to your employees. And the buildFilters to define the filters that are usable on the list.

### Display

To add a column to the display you need to add `addField`.

`addField` Parameters:

| Name | Type | Description | Example |
| --- | --- | --- | --- |
| name | string | The name of the field, it must correspond with the entity field otherwise an exception will be thrown. The name **MUST** be in snake case even if the entity has it in camel case. | email |
| type | string | The view type for the field. A valid view type with that name must exist otherwise an exception is thrown. | text |
| sortable | boolean | true or false if the list is sortable on this field | true |
| options | array | The options for the field. | ['default' => 'example.org'] | false |

#### Example Code

```php
class Section implments SectionInterface
{
   // ...
   public function buildListView(ListView $listView): ListView
   {
       $listView->addField("id", "text")
           ->addField("email", "text", true)
           ->addField("name", "text", true)
           ->addField("is_confirmed", "boolean");

       return $listView;
   }
   // ...
}
```

#### Example UI


![UI](/images/crud/list.png)

## Delete

The CRUD system supports soft deletes. These are deletes where the data isn’t actually deleted but marked as deleted. This allows for not only restoring the data at a later date in the case of accidental deletions but maintaining data integrity. This would be when you want to remove one part of data but you want to keep the other data that is related to it. For example, you may want to remove an item from your system but need to keep all billing data related to that item.

The logic for how the deletes are handled by the Repository. When these actions are called they just call the repository to delete/undelete the entity and redirect back to the read page.

**For something to be deletable in Athena it must implement the `\Parthenon\Athena\Entity\DeletableInterface`**

### Example Code

```php
namespace App\Entity;

class Demo implements \Parthenon\Athena\Entity\DeletableInterface
{
      private bool $deleted;
      private ?\DateTimeInterface $deletedAt;

      public function setDeletedAt(\DateTimeInterface $dateTime): self {
          $this->deletedAt = $dateTime;
          return $this;
      }

      public function isDeleted(): bool {
        return $this->deleted;
      }

      public function markAsDeleted(): self {
          $this->deleted = true;
          $this->deletedAt = new \DateTime('now');
          return $this;
      }

      public function unmarkAsDeleted(): self {
          $this->deleted = true;
          $this->deletedAt = null;

          return $this;
      }
}

```


## Filters

| Name | Type | Description | Example |
| --- | --- | --- | --- |
| name | string | The name of the field, it must correspond with the entity field otherwise an exception will be thrown. The name **MUST** be in snake case even if the entity has it in camel case. | email |
| type | string | The filter type to be used when filtering. This has to be the name of the filter type that is registered. Otherwise, an exception will be thrown. | contains |


:::note
name's of embedded associations must start with a fullstop. Example `.billingAddress.email` will be for an embedded association while `billingAddress.email` is for associations to entities.
:::

### Example Code

```php
class Section implements SectionInterface
{
    // ...    
    public function buildFilters(ListFilters $listFilters): ListFilters
    {
        $listFilters->add("name")
            ->add("email");

        return $listFilters;
    }
    // ...
}
```


### Example UI


![UI](/images/crud/list-filters.png)


## View Types

ViewTypes exist to allow for the customisation of displaying the data. Depending on what the data contains will change how you wish to view it. For example, you will want to display an image differently than you will want to display an ID.

### Example Code

```php
class BooleanViewType implements ViewTypeInterface
{
    private $data;

    public function getHtmlOutput(): string
    {
        return $this->data ? "True" : "False";
    }

    public function setData($data)
    {
        $this->data = $data;
    }

    public function getName(): string
    {
        return "boolean";
    }
}
```

## Settings

Within the CRUD system of the Athena there are settings for each section. This allows you to disable features you don't need. For example, making things uneditable or preventing employees from creating things by hand.

| Name | Description | Default |
| --- | --- | --- |
| saved_filters | This defines if a section will keep the filters that were previously used when the user returns later. | false |
| create | If create new entity is enabled | true |
| delete | If delete entity is enabled | true |
| undelete | If undelete entity is enabled | true |
| edit | If edit entity is enabled | true |

### Example Code

```php
class Section implments SectionInterface
{
    // ...
    public function getSettings(): Settings
    {
        return new Settings(['create' => false]);
    }
    // ...
}
```

## Repository

The parthenon Athena is designed to allow to almost any data source with the CRUD. This allows companies to grow and change datastores as their business grows instead of being coupled to one library. To enable this the CRUD functionality has its own Repository functionality.

The repository functionality is designed on the `CrudRespositoryInterface` which everything is coupled to. Each Section must return a repository to be used for it.

If you’re using Doctrine you just need to extend `DoctrineCrudRepository` which implements all the functionality required for the CRUD section.

For more overall information about repository please see the [commons repository documentation](../common/design-decisions/repositories.md)

## Buttons

To add buttons to the bottom of the read page of the CRUD you need to return an instance of `\Parthenon\Athena\Button` in an array.

| Arguments | Type | Description |
| --- | --- | --- |
| $name | string | The name is used as title in the html. It's way to make each button unique for testing purposes. |
| $label | string | The text to be shown on the button. This is ran through the localisation system. |
| $path | string | The symfony path that is used. The id of the entity is passed as `id`. |

### Example Code

```php
    public function getButtons() : array {
        $name = 'name of button';
        $label = 'app.button.label';
        $path = 'app_button_path';
        return [new Button($name, $label, $path)];
    }
```

## UI

There are some methods defined in the `SectionInterface` that are there to define where the section is accessible via the UI.

`SectionInterface::getMenuSection()` - This is what you want the main item on the UI to be called. This allows for the grouping together of multiple data to be contained within the same menu section thus making it easier for employees to navigate and manage the Athena.

`SectionInterface::getMenuName()` - The name that you want to be displayed within the menu section group for this crud section.

`SectionInterface::getUrlTag()` - The tag to be used in the URL to differenulate from different CRUD sections.

`SectionInterface::getButtons()` - The buttons that are to be shown on the read page of the crud.

### Example Code

```php
class Section implments SectionInterface
{
    // ...

    public function getUrlTag(): string
    {
        return "user";
    }

    public function getMenuSection(): string
    {
        return "Users";
    }

    public function getMenuName(): string
    {
        return "Manage";
    }


    public function getButtons(): array
    {
        return [
            new Button('campaign_generate_invoice', 'app.athena.campaigns.generate_invoice', 'app_athena_campaign_generate_invoice'),
        ];
    }
    // ...
}
```

## Example Output

![UI](/images/crud/ui.png)
