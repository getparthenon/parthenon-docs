---
title: "UI Information"
date: 2020-08-26T19:48:08+02:00
draft: false
---
* [Logo](#logo)
* [Templates](#templates)
* [Templates / CRUD Pagination](#crud-pagination)
* [Templates / Notifications](#notifications)
* [Templates / Side Menu](#side-menu)
* [Localisation](#localisation)

## Logo

To change the logos used for Athena you just need to set some configurations within the Parthenon YAML config file.

There are two configurations for

| Config Name | Example Value | Description |
| --- | --- | --- |
| dashboard_logo | https://example.org/dashboard_logo.jpg| The logo that is shown in the dashboard after the user has logged in. |
| login_logo      | https://example.org/login_logo.jpg | The logo that is shown when the user logs in. |

```YAML
parthenon:
  athena:
    enabled: true
    dashboard_logo: 'https://example.org/dashboard_logo.jpg' # The logo that is shown in the dashboard after the user has logged in.
    login_logo: 'https://example.org/login_logo.jpg' # The logo that is shown when the user logs in.
```

## Templates

To create your own templates for the Athena you'll need to use some of the custom twig functions.

### Crud Pagination

```html
{% if stepBackKey is not null %}
  <div class="col-sm-12 col-md-7">
    <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
      <ul class="pagination">
        <li class="paginate_button page-item next" id="dataTable_next"><a href="?sort_key={{ currentSortKey }}&sort_type={{ currentSortType }}&last_key={{ stepBackKey }}{{ athena_crud_filters_link(listFilters) }}" class="page-link">prev</a>
        </li>
      </ul>
    </div>
  </div>
{% endif %}
{% if results.hasMore %}
  <div class="col-sm-12 col-md-7">
    <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
      <ul class="pagination">
        <li class="paginate_button page-item next" id="dataTable_next"><a href="?sort_key={{ currentSortKey }}&sort_type={{ currentSortType }}&last_key={{ results.lastKey }}&step_back_key={{ currentLastKey }}{{ athena_crud_filters_link(listFilters) }}" id="crud_list_next" class="page-link">Next</a>
        </li>
     </ul>
    </div>
  </div>
{% endif %}
```

### Notifications

Fetch the notifcation entities with `athena_notifications`.

```html
<!-- Nav Item - Alerts -->
<li class="nav-item dropdown no-arrow mx-1">
    {% set notifications = athena_notifications() %}
    {% set notificationsCount =  notifications|count %}
    <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <i class="fas fa-bell fa-fw"></i>
        <!-- Counter - Alerts -->
        {% if notificationsCount > 0 %}
          <span class="badge badge-danger badge-counter">{{ notificationsCount }}</span>
        {% endif %}
    </a>
    <!-- Dropdown - Alerts -->
    {% if notificationsCount > 0 %}
        <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
        <h6 class="dropdown-header">
          {{ 'parthenon.athena.notifications.label'|trans }}
        </h6>

        {% for notification in notifications|slice(0,3)  %}
            <a class="dropdown-item d-flex align-items-center notification" href="{% if notification.link.isRaw %}{{ notification.link.urlName }}{% else %}{{ path(notification.link.urlName, notification.link.urlVariables) }}{% endif %}" data-id="{{ notification.id }}">
                <div class="mr-3">
                    <div class="icon-circle bg-primary">
                        <i class="fas fa-file-alt text-white"></i>
                    </div>
                </div>
                <div>
                    <div class="small text-gray-500">{{ notification.createdAt|date("Y-m-d") }}</div>
                    <span class="font-weight-bold">{{ notification.messageTemplate }}</span>
                </div>
            </a>
        {% endfor %}
        <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
        </div>
  {% endif %}
</li>
```

### Side Menu

For the side menu fetch the menu data with `athena_menu`.

```html

        <!-- Nav Item - Pages Collapse Menu -->
        {% for groupName, groupData in athena_menu()  %}
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapse{{ groupName|split(" ")|join }}" aria-expanded="true" aria-controls="collapseTwo">
                <i class="fas fa-fw fa-cog"></i>
                <span>{{ groupName|trans }}</span>
            </a>

            <div id="collapse{{ groupName|split(" ")|join }}" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    {% for sectionName, urlTag in groupData  %}
                        <a class="collapse-item" href="{{ path(urlTag) }}">{{ sectionName|trans }}</a>
                    {% endfor %}
                </div>
            </div>
        </li>

        {% endfor  %}

```



## Localisation

All the text displayed in the Athena UI with the exemption of entity data goes through the Symfony localisation system before being displayed.
