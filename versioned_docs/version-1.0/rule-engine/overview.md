---
title: "Rule Engine  - Overview"
date: 2020-09-04T17:30:32+02:00
draft: false  
sidebar_label: "Overview"
---
:::caution

This is a Professional Edition feature.

:::

The rule engine provided with parthenon is designed to allow company employees to define and automate tasks without requiring developer intervention. All the developer has to do is implement the actions that are allowed to be executed upon a rule being valid and define an entity as being able to have rules. The rule engine then checks the rule upon the entity being saved.

## Getting Started

To get started with the Rule Engine you need to do the following.

Add to your routes

```yaml
parthenon_rule_engine_controllers:
    resource: ../../vendor/Parthenon/RuleEngine/Controller/
    type: annotation
```

## Actions

To define actions for the Rule Engine you need to create an implementation of the `Parthenon\RuleEngine\Action\ActionInterface`.

### getOptions

`getOptions` returns an array. This array helps define what will be displayed on the create rule page when this Action is selected.

Each item in the array should contain the following keys

| Key | Example | Description |
| --- | --- | --- |
| type | text | What sort of input should be used. Valid options include text |
| name | email | What the name of the option should be. This is what the key for the option when passed to the action execute method. |
| label | E-Mail Address | The text that is shown on the form label |

### getName

Get name returns a string that is used to define the action in the dropdown for the create rule

### execute

The execute method contains the logic that is to be executed when the action is called.

It has the following arguments:

| name | type | description |
| --- | --- | --- |
| entity | object | The entity that the rule was triggered on |
| options | array | The options that were defined for the rule |

### Example Code

```php
class Email implements ActionInterface
{
    private SenderInterface $sender;

    public function __construct(SenderInterface $sender)
    {
        $this->sender = $sender;
    }

    public function getName(): string
    {
        return 'Email';
    }

    public function getOptions(): array
    {
        return [
            [
                'name' => 'address',
                'type' => 'text',
                'label' => 'E-mail Address',
            ],
            [
                'name' => 'temaple',
                'type' => 'text',
                'label' => 'Template',
            ],
         ];
    }

    public function execute(array $options, $entity): void
    {
        $message = Message::createForTemplate($options['template']);
        $message->setToAddress($options['to']);
        $this->sender->send($message);
    }
}
```

## Repository

To define which entities can have rules the repository needs to implement the `RuleEngineRepositoryInterface`.

The `RuleEngineRepositoryInterface` has the following methods.

### getEntity

It returns a blank entity that can have rules.
