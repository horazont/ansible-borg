## GENERATED BY ANSIBLE ##
# configuration for borg job {{ item.key }} on {{ item.value.repository }}
{% set repo = borg_repositories[item.value.repository] %}
export BORG_PASSPHRASE="{{ repo.passphrase }}"
export BORG_REPO="{{ repo.user }}@{{ repo.host }}:{{ repo.path }}"
{% if repo.executable | default(False) %}
export BORG_REMOTE_PATH="{{ repo.executable }}"
{% endif %}
export BORG_RSH="ssh -i /etc/borgbackup/repositories/{{ item.value.repository }}.key"
export PRUNE_FLAGS='-P {{ item.value.archive_prefix }}- {% for interval, amount in item.value.prune.items() %}--keep-{{ interval }} {{ amount }} {% endfor %}'
export CREATE_FLAGS='-x{% if item.value.compression | default(False) %} -C {{ item.value.compression }}{% endif %} ::{{ item.value.archive_prefix }}-{utcnow} {{ item.value.path }}'
export JOB_PATH="{{ item.value.path }}"
export JOB_NAME="{{ item.key }}"
export JOB_REPO="{{ item.value.repository }}"
