---
title: "User - Design Decisions"
sidebar_label: "Design Decisions"
date: 2020-08-26T19:43:24+02:00
draft: false
---


## Entity/Entity Factory

When doing background processes where the user keeps checking to see if the download is available, it's better if there is a database record that is read to see if there has been a change. To create flexibility we use super classes to define entities used with Parthenon, this means that you will create an class that extends the super class and are able to add extra fields. However, this means that the code saving the entity needs to get an instance of your class.

There are two options, create a parameter for the class name and dynamically create it. Or create an entity factory that is extended and overridden that returns a new instance of the class. By choosing the factory method it adds flexibility in the fact you can set custom fields on creation without hooking into events.
