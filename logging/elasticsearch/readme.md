# elasticsearch

### Roles Descriptions:

There are 2 roles that we can use to implement elasticsearch depending on the need.

Role Elasticsearch:
- Running this role create an elasticsearch instance on the server.

Role Elasticsearch_double_init
- Running this role, two instances of elasticsearch are created on the same server.

## Pre requirements


To execute the roles it's necessary to copy the elasticsearch rpm found in tvi059-arqsegwiki:/mnt/apt-mirror/middlesex/elk/elasticsearch/rpms/ into src directory that is inside the role to be executed

## To do:
- Configure the elasticsearch repository

##  Execution

One instance in a server:
- ansible-playbook -i inventory.ini pb_elastic-install.yml

Two instances in a server:
- ansible-playbook -i inventory.ini pb_elastic-install_double_init.yml
