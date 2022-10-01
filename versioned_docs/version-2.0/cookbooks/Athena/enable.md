---
title: "Enable Athena"
date: 2020-08-25T20:18:40+02:00
draft: false
---
Here is how to enable Athena.

# Step 1 - Enable Parthenon Config

Add to `parthenon.yaml` in your app config

```yaml
parthenon:
  athena:
    enabled: true
    host: '%env(resolve:ATHENA_HOST)%'
```

And add a `ATHENA_HOST` env variable.

# Step 2 - Add routing configuration

:::note

Routes are triggered in the order that they are defined so Athena should be at the top of your routing configuration to ensure it allows for the host to be used.

:::
```yaml
_app_athena:
    resource: .
    type: athena

```

# Step 3 - Add security.yaml configuration

Add the following firewall rule to your security configuration.

:::note

The firewall rules are triggered in order that they are defined so if you have a security firewall that is not restricted to a path,host, etc. Then put this firewall before that firewall.

:::

```yaml
security:
  firewalls:
    athena:
      host: '%env(resolve:ATHENA_HOST)%'
      stateless: false
      lazy: true
      provider: parthenon
      remember_me:
        secret: '%kernel.secret%'
        always_remember_me: true
      form_login:
        # "login" is the name of the route created previously
        login_path: parthenon_athena_login
        check_path: parthenon_athena_login
      logout:
        path: parthenon_user_logout

  access_control:
    - { path: ^/athena, roles: ROLE_ADMIN }

```
