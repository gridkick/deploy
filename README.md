Adventure Deploy
================

DevOps to the max! GridKick scripts using Ansible to build images.

## Requirements

* Vagrant >= 1.2.2
* Ruby >= 2.0.0
* Ansible >= 1.4
* Python >= 2.7 (not sure if 3 will work)

## SSH interaction between `deploy` and rails `api` app

The Rails API application kicks off Ansible playbooks against the customer 
database hosts. Since Ansible operates via SSH, we've added a `gridkickbackup` 
user and group. The Ansible operations are run through this user. The 
__passphrase-less__ private SSH key is located in 
`roles/api_ansible_keys/files/backup@gridkick.com`. __WARNING__: this must be 
passphrase-list since we're not injecting the passphrase to the background 
Ansible playbook runs at the moment.

## Setup "local" Environment

  Overall, we have 3 local VirtualBox backed servers, `api`, `mongo`, `redis`. 
  Each has a unique Vagrant implemented IP address, which is dynamically set in 
  each's Vagrant file (./Vagrantfiles/api.vagrant.rb) by referencing the VM's 
  seed file (./seeds/api.seed.rb). Giving each VM box an IP enables apps to 
  address each other via IP (EG, the `adventure_api` mongoid.yml defines the 
  mongo service endpoint via IP and Port).

  Now to the nitty girtty setup info.

  0. Define GridKick domains in your machine's `/etc/hosts` file. API and Frontend
  apps run on same VM box.
        
        ###
        # Host Database
        #
        # localhost is used to configure the loopback interface
        # when the system is booting.  Do not change this entry.
        ###
        127.0.0.1 localhost
        255.255.255.255 broadcasthost
        ::1             localhost 
        fe80::1%lo0 localhost

        ### gridkick                               ### NOTCE #############################
        192.168.211.218  local-api.gridkick.com    ###  <=  IP matches seeds/api.seed.rb
        192.168.211.218  local.gridkick.com        ###  <=  IP machtes seeds/frontend.seed.rb

  1. Bring GridKick components
      
        vagrant up api redis mongo
              
  2. Run Ansible Playbooks against all infrastructure. 

        ansible-playbook -i hosts/local.hosts core.yml redis.yml mongo.yml

  3. Deploy the ansible `deploy` repo to local server
        
        cap local deploy:setup
        cap local deploy


## Setup Staging/Production Env

  1. Add IPs to hosts file with proper groupings (IE, api/frontend/mongo/redis).
      
        [api]
        162.243.106.59

        [frontend]
        162.243.106.59

        [core:children]
        api
        frontend

        [redis]
        162.243.207.54

        [mongo]
        192.241.251.141

        [staging:children]
        api
        frontend
        mongo
        redis

        [change-ubuntu:children]
        staging

  2. Run ubuntu_prep against hosts:
        
        ansible-playbook \
          -i hosts/staging.hosts \
          ubuntu_prep.yml

  3. Run ansible-playbooks for total env:

        ansible-playbook \
          -K \
          -i hosts/staging.hosts \
          redis.yml \
          mongo.yml \
          core.yml

======================= weston broke this stuff :( =============================

## Instance Stuff 
  
  Setup

  * Setup seeds by copying files to the same location and removing `.example`
  * Pick a server to boot, e.g. `redis` and run `vagrant up redis`. This
    will run Ansible
  * To rerun ansible, execute `bin/redis/ansible`
  * To `ssh` into the redis VM, run `bin/redis/ssh`
  * If everything went well, you should be able to connect to the running
    redis server using `bin/redis/connect`
  * The same goes for other server types such as mysql or postgresql
    
  MySQL
  * To run `bin/redis/connect` you will need the `mysql` program installed locally.

  PostgreSQL
  * To run `bin/postgresql/connect` you will need the `psql` program installed locally.
  
  Redis
  * To run `bin/redis/connect` you will need the `redis-cli` program installed locally.
