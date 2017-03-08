#!/bin/bash
set -e

ansible-playbook test_defaults.yml

# running a second time to verify playbook's idempotence
set +e
ansible-playbook test_defaults.yml -vv > /tmp/second_run.log
{
    cat /tmp/second_run.log | tail -n 5 | grep 'changed=0' &&
    echo 'Playbook is idempotent'
} || {
    cat /tmp/second_run.log
    echo 'Playbook is **NOT** idempotent'
    exit 1
}

set -e
ansible-playbook test_addition.yml

# running a second time to verify playbook's idempotence
set +e
ansible-playbook test_addition.yml -vv > /tmp/second_run.log
{
    cat /tmp/second_run.log | tail -n 5 | grep 'changed=0' &&
    echo 'Playbook is idempotent'
} || {
    cat /tmp/second_run.log
    echo 'Playbook is **NOT** idempotent'
    exit 1
}

set -e
ansible-playbook test_removal.yml

# running a second time to verify playbook's idempotence
set +e
ansible-playbook test_removal.yml -vv > /tmp/second_run.log
{
    cat /tmp/second_run.log | tail -n 5 | grep 'changed=0' &&
    echo 'Playbook is idempotent'
} || {
    cat /tmp/second_run.log
    echo 'Playbook is **NOT** idempotent'
    exit 1
}
