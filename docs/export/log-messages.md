---
title: "Export - Log Messages"
sidebar_label: "Log Messages"
date: 2020-08-25T20:21:11+02:00
draft: false
---
If you've got logging enabled you may want non-technical people to be able to find logs. Therefore, we provide the log messages the level and when they get called.

| Level | Message  | When it gets written | Notes |
| --- | --- | --- | --- |
| INFO | Starting a direct download export | When an export request starts being processed and the engine being used is DirectDownload. | n/a |
| INFO | Finishing a direct download export | When an export request finishes being processed and the engine being used is DirectDownload. | n/a |
| INFO | Queuing a background email export | When an export request is started and the engine being used is BackgroundEmailEngine | n/a |
| INFO | Queuing a background download export | When an export request is started and the engine being used is BackgroundDownloadEngine | n/a |
| INFO | Processing background email export request | When the messenger handler for the background email is started | n/a |
| INFO | Finished processing background email export request | When the messenger handler for the background email has finished | n/a |
| INFO | Processing background download export request | When the messenger handler for the background download is started | n/a |
| INFO | Finished processing background download export request | When the messenger handler for the background download has finished | n/a |
