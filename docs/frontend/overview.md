---
title: "Frontend"
date: 2020-09-04T17:30:32+02:00
draft: false
sidebar_position: 1
---
Parthenon comes with an array of Frontend libraries to help speed up the development.

## Tech Stack

Parthenon is built on some of the best technologies available.

* VueJs 3
* Vuex 3
* TailwindCss
* Jest
* Axios
* Font Awesome

## Folder composition

```
> /assets/
 | -> /styles - Style
 |     | -> app.css - Main css
 | -> /helpers/ - Helpers
 |     | -> router.js - The router configuration
 |     | -> app.routes.js - The internal application routes.
 | -> /modules/ - Packages
 |     | -> parthenon-menu/ - Parthenon Menu package
 | -> /services/ - The code that calls the backend.
 |     | -> /__tests__/ - Tests
 |     | -> userservice.js - Handles the calls to the backend for user actions.
 | -> /store/ - Vuex stores
 |     | -> user.store.js - Contains the Vuex code relating to the user
 |     | -> index.js - Groups the Vuex stores into one store.
 | -> /translations/ - The translations used with i18n
 |     | -> /en/
 |     |    | -> /public/
 |     |    |    | -> index.js - Groups the public translations
 |     |    |    | -> confirm_email.js - Confirm email translations
 |     |    |    | -> forgot_password.js - Forgot password translations
 |     |    |    | -> forgot_password_confirm.js - Forgot password confirm translations
 |     |    |    | -> login.js - Login translations
 |     |    |    | -> signup.js - Signup translations   
 |     |    | -> global.js - Global translations
 |     | en.js - Groups the English translations
 | -> /views/ - The vue components used to display pages
 |     | -> /app/ - The app views
```
