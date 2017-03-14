[![Build Status](https://travis-ci.org/danvaida/ansible-roles-route53.svg?branch=master)](https://travis-ci.org/danvaida/ansible-roles-route53)
[![Galaxy](https://img.shields.io/ansible/role/16135.svg)](https://galaxy.ansible.com/danvaida/route53/)

# Ansible Route53 role

Creates, updates and deletes DNS zones and records in Route53.

## Requirements

* boto >= 2.24.0

## Role Variables

* __route53_records_to_add:__
  List of DNS zone records to add. For differences between a `CNAME` record and a Route53-specific `alias` record, see the official docs [here](http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resource-record-sets-choosing-alias-non-alias.html)

* __route53_records_to_remove:__
  List of DNS zone records to remove.

* __route53_zones_to_add:__
  List of DNS zones to add.

* __route53_zones_to_remove:__
  List of DNS zones to remove.

## Dependencies

None.

## Example Playbook

    - hosts: localhost
      connection: local
      gather_facts: False
      become: False
      roles:
        - role: route53
          route53_zones_to_add:
            - zone: 'zone.xxx'
              comment: 'some comment'
              vpc_id: vpc-12345678
              vpc_region: 'eu-central-1'

          route53_records_to_add:
            - zone: 'zone.xxx'
              private_zone: True
              comment: 'zone comment'
              records:
                - record: 'in.the.zone.xxx'
                  type: A
                  ttl: 600
                  value: '1.1.1.1'

                - record: 'by.the.zone.xxx'
                  type: CNAME
                  ttl: 300
                  value: 'in.the.zone.xxx'

                - record: 'to.the.zone.xxx'
                  type: A
                  value: 'in.the.zone.xxx.'
                  alias: True
                  alias_hosted_zone_id: 'ABCD1234567890'

          route53_records_to_remove:
            - zone: 'zone.xxx'
              private_zone: True
              records:
                - record: 'in.the.zone.xxx'
                  type: A
                  ttl: 600
                  value: '1.1.1.1'

                - record: 'by.the.zone.xxx'
                  type: CNAME
                  ttl: 300
                  value: 'in.the.zone.xxx'

                - record: 'to.the.zone.xxx'
                  type: A
                  value: 'in.the.zone.xxx'
                  alias: True
                  alias_hosted_zone_id: 'ABCD1234567890'

          route53_zones_to_remove:
            - zone: 'zone.xxx'

## Testing

If you want to run the tests on the provided docker environment, run the
following commands:

    $ cd /path/to/ansible-roles/route53
    $ docker build -t ansible-roles-test tests/support
    $ docker run --rm -it \
      -v $PWD:/etc/ansible/roles/route53 \
      --env AWS_ACCESS_KEY=$AWS_ACCESS_KEY \
      --env AWS_SECRET_KEY=$AWS_SECRET_KEY \
      --env AWS_REGION=$AWS_REGION \
      --workdir /etc/ansible/roles/route53/tests \
      ansible-roles-test

# To do

* Add integration tests for private zones
