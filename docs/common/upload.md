---
title: "Upload"
date: 2020-09-26T20:29:29+02:00
draft: False
---
To upload files there is the UploaderInterface. The UploaderInterface just returns an instance of File that provides a path for the file.


## Config

| Config Name | Example | Required | Description |
| --- | --- | --- | --- |
| provider | s3 | true | The mailing service to be used. Options are: null, sendgrid, mailgun, postmark |
| naming_strategy | random_time | true | |
| s3 | n/a | false | The S3 options as defined in the [AWS S3](#aws_s3) section below. |
| local | n/a | false | The local options as defined in the [local](#local) section below. |
| url | https://public.url/ | true | The base url the file will be located at. |

## Fetching an Uploader

To get the uploader you can just autowire `Parthenon\Common\Upload\UploaderInterface`. And that will inject either the uploader called default or if there is only one it'll inject that.

{{% notice info %}}
If you have more than one uploader and neither are called default. Autowiring will result in an exception for no found uploader being flung.
{{% /notice %}}

The other way to get the uploader is to call the `Parthenon\Common\Upload\UploaderManager::getUploader`. This can be injected via autowiring with the interface `Parthenon\Common\Upload\UploaderManagerInterface`.

```PHP
use Parthenon\Common\Upload\UploadManager;

class Controller {
    public function uploadAction(Request $request, UploaderManagerInterface $uploaderManager) {
      $uploader = $uploaderManager->getUploader('profile_images');
      // do stuff with uploader
    }
}
```

## Creating your own uploader

```php
namespace Parthenon\Common\Upload;

use Symfony\Component\HttpFoundation\File\UploadedFile;

interface UploaderInterface
{

    public function uploadString(string $filename, string $contents): File;

    public function uploadUploadedFile(UploadedFile $file): File;

    public function deleteFile(File $file): void;

    /**
     * @return resource
     */
    public function readFile(File $file);
}
```

You need to implement three methods, Upload that accepts a Symfony `UploadedFile`, a delete, and a read both of which accept the Parthenon `File` object.

### uploadString

This accepts a string for the filename and a string for the contents instance of `File`

### uploadUploadedFile

This accepts an instance of `UploadedFile` and returns an instance of `File`

### deleteFile

This accepts an instance of `File` and returns nothing

### readFile

This accepts an instance of `File` and returns a stream.


## Naming

Often there is a need for files to be named in a specific way.

```php
namespace Parthenon\Common\Upload;

interface NamingStrategyInterface
{
    public function getName(string $filename): string;
}
```

### Strategies

| Name | Description |
| --- | --- |
| md5_time | This creates a md5 hash from the file name and then suffixes a unix timestamp to the end. This does result in a guessable filename. |
| random_time | This this creates a random string that has the timestamp suffixed to it. |

## Flysystem

Flysystem is an extremely good uploading library that can be used for upload files to multiple systems. There is a wrapper for his library to allow use while also allowing for potential competitors in the future to be usable.

## AWS S3

| Config Name | Example | Required | Description |
| --- | --- | --- | --- |
| key | s3 | true | Your client key to AWS |
| secret | random_time | true | Your secret for AWS |
| region | fra1 | true | The name of the region you're going to upload to |
| endpoint | https://fra1.digitaloceanspaces.com | true | The url to the AWS APIs. |
| bucket_name | bucket_name | true |  the name of the bucket you're uploading to. |
| visibility | public | false | Wether or not you want the file to be publically accessible or not |

```yaml
parthenon:
    common:
        uploader:
            default:
                provider: s3
                naming_strategy: random_time
                url: '%env(resolve:UPLOAD_ACCESS_URL)%'
                s3:
                    key: '%env(resolve:DIGITALOCEAN_SPACES_KEY)%'
                    secret: '%env(resolve:DIGITALOCEAN_SPACES_SECRET)%'
                    region: '%env(resolve:DIGITALOCEAN_SPACES_REGION)%'
                    endpoint: '%env(resolve:DIGITALOCEAN_SPACES_ENDPOINT)%'
                    bucket_name: '%env(resolve:DIGITALOCEAN_SPACES_BUCKET)%'
                    visibility: 'public'
```

## Local

To upload to the local file system.

| Config Name | Example | Required | Description |
| --- | --- | --- | --- |
| path | /tmp | true | The location on your local filesystem to store the file. |

```YAML
parthenon:
  common:
    uploader:
      default:
        provider: local
        naming_strategy: time_random
        local:
          path: "%kernel.project_dir%/public/uploads"
```
