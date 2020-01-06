Ansible Test Image - Debian 8 (Buster)
=======================================

[![Build Status](https://travis-ci.com/vantaworks/docker-debian8-ansible.svg?branch=master)](https://travis-ci.com/vantaworks/docker-debian8-ansible)

This Docker container serves as a isolated testing environment for the development of Ansible roles and Playbooks and is part of a suite Docker images for that purpose. The primary use case is for [Molecule](https://molecule.readthedocs.io/en/stable/) testing. __It is not intended for production applications__.  

Included Ansible developement tools
* yamllint
* ansible-lint
* flake8
* testinfra
* molecule

Manual Build
------------
Upstream images will be provided automatically; however, for manual builds, the only pre-requisite is Docker installed on your system and a local checkout of this repo.

1. `cd` to you local checkout of this repo
2. Run `docker build -t docker-debian8-ansible` or `make dist`

Manual Usage
------------

These steps are only required if manual, one-off testing is used.

1. Pull the image (skip if you manually built it): `docker pull thisisvantaworks/debian8-ansible:latest`
2. Run the container:

```
docker run --detach --privileged \
  --name docker-debian8-ansible \
  --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
  --volume=`pwd`:/etc/ansible/roles/<role_under_test>:ro \
  thisisvantaworks/debian8-ansible:latest
```

_Replace `<role_under_test>` with the name of your role._

3. Execute `ansible-playbook` thusly: 
```
docker exec -it docker-debian8-ansible \
  env TERM=xterm \
  ansible-playbook /path/to/ansible/playbook.yml \
  --syntax-check
```

Automated Build + Sanity Checks
-------------------------------
Build the container, and perform the supplied sanity checks by using the `all` make target. This is the proceedure used by automated builds to verify the container's functionality.

```
make all
```

Recommendations
---------------
For Playbook Testing: I highly recommend looking into [Molecule](https://molecule.readthedocs.io/en/stable/)

Credits
-------
Huge thanks to [Jeff Geerling](https://github.com/geerlingguy), which much of this repo's content is inspired by.
