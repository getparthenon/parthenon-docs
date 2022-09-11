---
title: "Pdf Generation"
date: 2020-09-26T20:29:24+02:00
draft: false
---
To generate PDF from HTML and CSS you just need to pass the entire HTML and CSS to the pdf generator. To allow for easy switching between rendering engines we support multiple ways of generating PDFs and they can be switched between via the configuration.

## Example Code

```php

use Parthenon\Common\Pdf\GeneratorInterface;

function pdfGenerate(GeneratorInterface $generator)
{
  $pdf = $generator->generate('<b>HELLO WORLD</b>');
}
```

## Configuration

All these configurations are under the `parthenon.common` configuration section.

| name | default | description |
| --- | --- | --- |
| generator | null | What PDF generation method should be used. wkhtmltopdf, docraptor, mpdf |
| wkhtmltopdf.bin | /usr/bin/wkhtmltopdf | The location of the wkhtmltopdf |
| docraptor.api_key | null | The API key to be used with docraptor |
| mpdf.tmp_dir | /tmp | The temporary directory that mpdf should use. |

### Example
```YAML
parthenon:
  common:
    pdf:
      generator: 'mpdf'
      mpdf:
        tmp_dir: '/tmp'  
      wkhtmltopdf:
        bin: '/usr/bin/wkhtmltopdf'
      docraptor:
        api_key: 'docraptor-api-key'  
```

## Snappy/wkhtmltopdf

Snappy is a library to wrap the wkhtmltopdf. This allows generating pdfs using wkhtmltopdf and requires that wkhtmltopdf is install locally on the web server.

To install the snappy library you need to run:
```
composer require knplabs/knp-snappy
```

```YAML
parthenon:
  common:
    pdf:
      generator: 'wkhtmltopdf'
      wkhtmltopdf:
        bin: '/usr/bin/wkhtmltopdf'
```

## DocRaptor

To use the DocRaptor you just need to include the docraptor library and configure your API key.

```
composer require DocRaptor/docraptor
```

# MPDF

To install the mpdf library you need to run:
```
composer require mpdf/mpdf
```
