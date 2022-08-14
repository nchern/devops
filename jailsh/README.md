# Jailsh - sandboxed shell


The main use case - ssh into a container on the host system to provide better isolation of remote users.
Jailsh gives a possibility to map a directory from the host into a container as a home dir.

## Installation

### 1. Install scripts and build an image

**Important:** Users that will use jailsh must exist inside the container.
Installation process allows you to specify users to be created during image build.

```sh
make all
```

### 2. Set up users and their ssh options
This is a manual step.

The user in question should be able to run `jailsh` as a sudoer.
In this example it is assumed that `$HOME/sandbox` exists for this user and it will be its home dir in a sandbox.

There are two options: tweak `sshd_config` or configure an individual public key in user's `authorized_keys`.

#### Tweak sshd_config

Add the following lines into your `sshd_config`
```
Match User <jailed-user>
    ForceCommand sudo -E jailsh $HOME/sandbox
```

and restart `sshd`.

#### Configure a specific public key

Open `/home/<jailed-user>/.ssh/authorized_keys`and 
prepend the following line to a selected pub key: `restrict,command="sudo -E jailsh $HOME/sandbox",pty `

Result should look like this:
```
restrict,command="sudo -E jailsh $HOME/sandbox",pty ssh-rsa AAAAB3NzaC1yc2EAA....`
```
