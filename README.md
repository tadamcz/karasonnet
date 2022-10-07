My [Karabiner-Elements](https://karabiner-elements.pqrs.org/) configuration, generated using [Jsonnet](https://jsonnet.org/).

Jsonnet is an intuitive superset of JSON that can be used to simplify the management of sprawling configuration files.

# Usage

Modify the files under `jsonnet` however you desire. For most uses, you should be able to leave the `.libsonnet` files unchanged and simply customise your configuration in `karabiner.jsonnet`.

Generate `karabiner.json` (in the current directory):

```shel
./generate.sh
```

Generate `karabiner.json`, and use it to replace your system configuration:

```shell
./overwrite_system_config.sh
```

The new configuration should be immediately picked up by Karabiner. Note that your previous system configuration will be backed up to `~/.config/karabiner/automatic_backups`, the same location used by Karabiner itself for backups.