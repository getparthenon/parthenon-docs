---
title: "Exporter"
date: 2020-09-26T20:29:24+02:00
draft: false
---
The ability to export data is a common task. To make this easier Parthenon comes with Exporter classes.

# CSV

Exporting to CSV is a common task. It converts an array of associtive arrays to a csv using the keys as column names.


```php
use Parthenon\Common\Export\CsvExporter;

$csvExporter = new CsvExporter();
$rows = [
        ['column_one' => 'value', 'column_two' => 'value_two'],
        ['column_three' => 'value_three', 'column_two' => 'value_four'],
      ];
$csvText = $exporter->getOutput($rows);
```

`$csvText` would contain:

```
column_one,column_two,column_three
value,value_two,
,value_four,value_three
```
