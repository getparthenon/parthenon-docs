---
title: "Internals"
date: 2020-08-26T19:48:08+02:00
draft: false
---
Here is an explaination of what is going on under the hood.

# Parthenon\Athena\SectionInterface

In the extension configuration code for Athena it's sets a tag for all services that implement the `Parthenon\Athena\SectionInterface` that tag is `parthenon.athena.section`.

Within the compiler pass it then finds all services tagged with `parthenon.athena.section` and then goes through all services finding out if they extend another service tagged with `parthenon.athena.section`. This will allow people to extend and override Athena sections provided by Parthenon. Once it's found unique sections it then builds a CRUD controller service for each section. And then it adds factory services for the export normalisers so that when you define a normaliser within the Athena section using `getNormaliser` method it will be available for the Export system.

## Export Normalisers

The export normalisers for Athena sections are created in the `NormaliserBuilder` which is passed to the Section by `Parthenon\Athena\Export\NormaliserFactory`.

The NormaliserFactory is used as a factory class for a service created by the Athena Compiler Pass. The factory service is tagged with the Normaliser tag. Then all services tagged as a normaliser are injected into the `NormaliserManager`. The `NormaliserManager` is then queried to provide the normaliser for an export and the Normaliser for the Athena section will be available.
