---
title: "Getting Started With The User System"
date: 2020-08-25T20:19:24+02:00
draft: false
sidebar_position: 2
---
To get started using the Parthenon user module you will need to make a few small changes to your application.

### Configuration

There are some configurations for the user module of Parthenon. These can be configured within the parthenon.yaml Symfony configuration file that should be within the `config/packages/` directory of your Symfony application.

| Name | Type | Description | Default Value |
| --- | --- | --- | --- |
| enabled | Boolean | To define if the user module is enabled. | false |
| teams_enabled | Boolean | Defines if teams are enabled. If they are a team is created upon a new user sign up. | false |
| login_path | String | The path where users should be redirected to when they log in. | app_user_profile |
| signup_success_path | String | The path where users should be redirected to when they sign up. | app_user_signed_up |
| confirm_email | boolean | If users are required to confirm their email before using the system | false |
| gdpr.exporter.formatter_type | string | This is the name of the exporter formatter to be used. | json |
| teams_invites_enabled | boolean | If there can be team invites used | false |
| user_invites_enabled | boolean | If there can be normal user invites used | false |
| self_signup_enabled | boolean | If a user can sign up without an invite | false |
| roles.default_role | string | The default role given to a user when they sign up | USER_ROLE |
| roles.user_assignable | array | A list of roles that can be assigned and invited to by a user | empty |
| roles.athena_assignable | array | A list of roles that can be assigned via Athena. | empty |

#### Example

```yaml
parthenon:
  user:
    enabled: true
    teams_enabled: true
```

### Doctrine ORM Configuration

You'll need to make some changes to the doctrine orm configuration. You need to add the references for your classes that implement the Parthenon user interfaces. And to include the mappings for the Parthenon entities.

```yaml
doctrine:
    orm:
        resolve_target_entities:
            Parthenon\User\Entity\UserInterface: App\Entity\User
            Parthenon\User\Entity\TeamInterface: App\Entity\Team
```

## Doctrine ODM Configuration

You'll need to make some changes to the doctrine mongodb configuration. You need to add the references for your classes that implement the Parthenon user interfaces.

```yaml
doctrine_mongodb:
    resolve_target_documents:
        Parthenon\User\Entity\UserInterface: App\Document\User
        Parthenon\User\Entity\TeamInterface: App\Document\Team
```
