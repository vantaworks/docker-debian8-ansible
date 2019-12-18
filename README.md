Ansible Test Image - Debian 8 (Jessie)
======================================
This Docker container serves as a isolated testing environment for the development of Ansible roles and Playbooks on multiple operating systems. The primary use case was for [Molecule](https://molecule.readthedocs.io/en/stable/) testing. __It is not intended for production applications__.  

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
2. Run `docker build -t debian8-ansible .`

Usage
-----

1. Pull the image (skip if you manually built it): `docker pull vantaworks/docker-debian8-ansible:latest`
2. Running the image:

Upstream: `docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro vantaworks/docker-debian8-ansible:latest`

Maually built: `docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro debian8-ansible:latest`

3. For Playbook Testing: I highly recommend looking into [Molecule](https://molecule.readthedocs.io/en/stable/)

Credits
-------
Huge thanks to [Jeff Geerling](https://github.com/geerlingguy), which much of this repo's content is inspired by.
