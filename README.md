# borg role

## Example configuration

```yaml
# for a source host called "elara" backing up to a backup service called
# "gluon", a config may look like this

borg_jobs:
- name: postgresql
  # refers to the borg_repositories entry below
  repository: gluon
  compression: "none"
  # followed by `-{utcnow}` when used in a borg create call, and used to find archives to prune
  archive_prefix: "elara-var-lib-postgresql-backups"
  # crontab format
  archive_rhythm: "50 * * * *"
  prune_rhythm: "30 3 * * *"
  prune:
    # how many archives to keep
    hourly: 24
    daily: 7
  # FWIW, this directory is populated by another script (not included)
  path: /var/lib/postgresql-backups

borg_repositories:
  gluon:
    # ssh host
    host: "gluon.h.sotecware.net"
    # ssh user
    user: "elara-backup"
    # path to the repository
    path: "/mnt/backups-mailio/elara-backup/main/"
    # repository passphrase; you'll want to get those secrets from ansible-vault, git crypt or whatever
    passphrase: "{{ elara_borg_to_gluon_passphrase }}"
    # custom executable path, is probably optional
    executable: "/usr/bin/borg"
    # ssh private key
    private_key: "{{ elara_borg_to_gluon_private_key }}"
```
