# Singularity iRODS: iCommands

[![https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg](https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg)](https://singularity-hub.org/collections/812)
[![GitHub License](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)

Singularity image for [iRODS iCommands](https://docs.irods.org/4.2.2/system_overview/glossary/#icommands).

## Build

You can build a local Singularity image named `icommands.4.2.2.simg` with:

```
$ sudo singularity build icommands.4.2.2.simg Singularity
```

## Deploy

Instead of building it yourself you can download the pre-built image from
[Singularity Hub](https://www.singularity-hub.org) with:

```bash
singularity pull --name icommands.4.2.2.simg shub://mjstealey/singularity-irods-icommands
```

## Usage

Help

```console
$ singularity help icommands.4.2.2.simg

  iRODS Version 4.2.2

  $ singularity run icommands.4.2.2.simg [icommand] [args]
  $ singularity run --app iinit icommands.4.2.2.simg
  $ singularity run --app iinit icommands.4.2.2.simg [args]
    Where [args] in
    --irods_host String
    --irods_port Integer
    --irods_user_name String
    --irods_zone_name String
    --irods_password String
    --irods_default_resource String
    --irods_home String
```

## Run

```bash
singularity run icommands.4.2.2.simg [icommand] [args]
```
Or

```bash
./icommands.4.2.2.simg [icommand] [args]
```

Where `[icommand]` is a valid [iRODS iCommand](https://docs.irods.org/4.2.2/icommands/user/) and [`args`] is zero or more supporting arguments for that iCommand.

Prior to initializing your iRODS environment using `iinit`, the only valid iCommand will be `ihelp`.

Example

```console
$ singularity run icommands.4.2.2.simg ihelp
The iCommands and a brief description of each:

iadmin       - perform iRODS administrator operations (iRODS admins only).
ibun         - upload/download structured (tar) files.
icd          - change the current working directory (Collection).
ichksum      - checksum one or more Data Objects or Collections.
ichmod       - change access permissions to Collections or Data Objects.
icp          - copy a data-object (file) or Collection (directory) to another.
ienv         - display current iRODS environment.
ierror       - convert an iRODS error code to text.
iexecmd      - remotely execute special commands.
iexit        - exit an iRODS session (opposite of iinit).
ifsck        - check if local files/directories are consistent with the associated Data Objects/Collections in iRODS.
iget         - get a file from iRODS.
igroupadmin  - perform group-admin functions: mkuser, add/remove from group, etc.
ihelp        - display a synopsis list of the iCommands.
iinit        - initialize a session, so you don't need to retype your password.
ils          - list Collections (directories) and Data Objects (files).
ilsresc      - list iRODS resources.
imcoll       - manage mounted collections and associated cache.
imeta        - add/remove/copy/list/query user-defined metadata.
imiscsvrinfo - retrieve basic server information.
imkdir       - make an iRODS directory (Collection).
imv          - move/rename an iRODS Data Object (file) or Collection (directory).
ipasswd      - change your iRODS password.
iphybun      - DEPRECATED - physically bundle files (admin only).
iphymv       - physically move a Data Object to another storage Resource.
ips          - display iRODS agent (server) connection information.
iput         - put (store) a file into iRODS.
ipwd         - print the current working directory (Collection) name.
iqdel        - remove a delayed rule (owned by you) from the queue.
iqmod        - modify certain values in existing delayed rules (owned by you).
iqstat       - show the queue status of delayed rules.
iquest       - issue a question (query on system/user-defined metadata).
iquota       - show information on iRODS quotas (if any).
ireg         - register a file or directory/files/subdirectories into iRODS.
irepl        - replicate a file in iRODS to another storage resource.
irm          - remove one or more Data Objects or Collections.
irmdir       - removes an empty Collection
irmtrash     - remove Data Objects from the trash bin.
irsync       - synchronize Collections between a local/iRODS or iRODS/iRODS.
irule        - submit a rule to be executed by the iRODS server.
iscan        - check if local file or directory is registered in iRODS.
isysmeta     - show or modify system metadata.
iticket      - create, delete, modify & list tickets (alternative access strings).
itrim        - trim down the number of replicas of Data Objects.
iuserinfo    - show information about your iRODS user account.
ixmsg        - send/receive iRODS xMessage System messages.
izonereport  - generates a full diagnostic/backup report of your Zone.

For more information on a particular iCommand:
 '<iCommand> -h'
or
 'ihelp <iCommand>'

iRODS Version 4.2.2                ihelp
```

## iinit (no args)

The `iinit` command is launched as an explicit app:

```bash
$ singularity run --app iinit icommands.4.2.2.simg
```

If no arguments are passed in the user will be walked through the `iinit` process

Example:

```console
$ singularity run --app iinit icommands.4.2.2.simg
 ERROR: environment_properties::capture: missing environment file. should be at [/home/stealey/.irods/irods_environment.json]
One or more fields in your iRODS environment file (irods_environment.json) are
missing; please enter them.
Enter the host name (DNS) of the server to connect to: nwm.renci.org
Enter the port number: 1247
Enter your irods user name: nwm-reader
Enter your irods zone: nwmZone
Those values will be added to your environment file (for use by
other iCommands) if the login succeeds.

Enter your current iRODS password: nwmreader
IINIT: $HOME/.irods/irods_environment.json
{
    "irods_host": "nwm.renci.org",
    "irods_port": 1247,
    "irods_zone_name": "nwmZone",
    "irods_user_name": "nwm-reader"
}
```

This will also result in two new files being created in the users `$HOME/.irods` directory.

```
$ ls -alh $HOME/.irods
-rw-------  1 xxxxx xxxxx   17 Mar 26 14:44 .irodsA
-rw-r--r--  1 xxxxx xxxxx  133 Mar 26 14:44 irods_environment.json
```

Where:

- `irods_environment.json` is the JSON definition for the iRODS connection (as seen at the end of the `iinit` command output).
- `.irodsA` is the hashed value of the user's iRODS password.

## iinit (with args)

The `iinit` command is launched as an explicit app:

```bash
singularity run --app iinit icommands.4.2.2.simg [args]
```

Valid args

```
-h | --irods_host as String
-p | --irods_port as Integer
-u | --irods_user_name as String
-z | --irods_zone_name as String
-s | --irods_password as String
-d | --irods_default_resource as String
-m | --irods_home as String
```

If arguments are passed in the script will attempt the `iinit` process using a combination of preexisting information in the `irods_environment.json` file along with the arguments passed in by the user.

- If the `--irods_password` argument is populated the user will not be prompted for the password, but may notice an `Inappropriate ioctl` warning at the prompt.

    ```
    /bin/stty: 'standard input': Inappropriate ioctl for device
    /bin/stty: 'standard input': Inappropriate ioctl for device
    ```

Example:

```console
$ singularity run --app iinit icommands.4.2.2.simg \
>   --irods_host nwm.renci.org \
>   --irods_port 1247 \
>   --irods_user_name nwm-reader \
>   --irods_zone_name nwmZone \
>   --irods_password nwmreader \
>   --irods_default_resource nwmResc \
>   --irods_home /nwmZone/home/nwm/data
/bin/stty: 'standard input': Inappropriate ioctl for device
/bin/stty: 'standard input': Inappropriate ioctl for device
Enter your current iRODS password:
IINIT: $HOME/.irods/irods_environment.json
{
  "irods_host": "nwm.renci.org",
  "irods_port": 1247,
  "irods_zone_name": "nwmZone",
  "irods_user_name": "nwm-reader",
  "irods_default_resource": "nwmResc",
  "irods_home": "/nwmZone/home/nwm/data"
}
```

## iCommands

Once the user has established their iRODS identity using the `iinit` command, they can issue a variety of iCommands. Examples given assuming prior initialization for [nwm.renci.org]().

**Example**: `ils`

```console
$ singularity run icommands.4.2.2.simg ils
/nwmZone/home/nwm/data:
  C- /nwmZone/home/nwm/data/analysis_assim
  C- /nwmZone/home/nwm/data/fe_analysis_assim
  C- /nwmZone/home/nwm/data/forcing_analysis_assim
  C- /nwmZone/home/nwm/data/forcing_medium_range
  C- /nwmZone/home/nwm/data/forcing_short_range
  C- /nwmZone/home/nwm/data/long_range
  C- /nwmZone/home/nwm/data/medium_range
  C- /nwmZone/home/nwm/data/nomads
  C- /nwmZone/home/nwm/data/short_range
  C- /nwmZone/home/nwm/data/usgs_timeslices
```

**Example**: `ils /nwmZone/home/nwm/data/nomads`

```console
$ singularity run icommands.4.2.2.simg ils /nwmZone/home/nwm/data/nomads
/nwmZone/home/nwm/data/nomads:
  C- /nwmZone/home/nwm/data/nomads/nwm.20180214
  C- /nwmZone/home/nwm/data/nomads/nwm.20180215
  ...
  C- /nwmZone/home/nwm/data/nomads/nwm.20180325
  C- /nwmZone/home/nwm/data/nomads/nwm.20180326
```

**Example**: `iget /nwmZone/home/nwm/data/nomads/nwm.20180325/short_range/nwm.t23z.short_range.channel_rt.f001.conus.nc`

```console
$ singularity run icommands.4.2.2.simg iget /nwmZone/home/nwm/data/nomads/nwm.20180325/short_range/nwm.t23z.short_range.channel_rt.f001.conus.nc
```

Verify file on local system.

```console
$ ls -alh $(pwd)/nwm.t23z.short_range.channel_rt.f001.conus.nc
-rw-r----- 1 xxxxx xxxxx 12M Mar 26 14:55 /home/stealey/irods-icommands-singularity/nwm.t23z.short_range.channel_rt.f001.conus.nc
```

- **NOTE**: By default Singularity will mount `$PWD`, `$HOME` and `/tmp` from the local file system to the container, so files that are retrieved from iRODS using `iget` will be saved to `$PWD` unless specified otherwise.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/mjstealey/singularity-irods-icommands](https://github.com/mjstealey/singularity-irods-icommands).

## License

The code is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
