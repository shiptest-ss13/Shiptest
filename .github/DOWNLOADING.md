# DOWNLOADING
There are a number of ways to download the source code. Some are described here, an alternative all-inclusive guide is also located at https://wiki.boomerstation.space/Downloading_the_source_code

## Option 1

Follow this: https://wiki.boomerstation.space/Setting_up_git

## Option 2

Download the source code as a zip by clicking the ZIP button in the
code tab of https://github.com/tgstation/tgstation
(note: this will use a lot of bandwidth if you wish to update and is a lot of
hassle if you want to make any changes at all, so it's not recommended.)

**WARNING: OPTIONS 3 AND 4 ARE NOT AVAILABLE FOR WASPCODE, THESE ARE FOR /TG/ ONLY AS OF NOW**

## Option 3

Download a pre-compiled nightly at https://tgstation13.download/nightlies/ (same caveats as option 2)

*Warning: option 4 is out of date, and not maintained, use at your own risk*

## Option 4

Use our docker image that tracks the master branch (See commits for build status. Again, same caveats as option 2)

```
docker run -d -p <your port>:1337 -v /path/to/your/config:/tgstation/config -v /path/to/your/data:/tgstation/data tgstation/tgstation <dream daemon options i.e. -public or -params>
```

