---
title: "Common - Design Decisions - General"
date: 2020-08-25T20:17:44+02:00
draft: false
---
## UploaderInterface

The uploader can handle uploading, deleting, and reading files to encapsulate the logic and these are common tasks when doing file uploads.

### readFile

Read file returns a stream as it's thought this provides the most flexibility in handling the output.
