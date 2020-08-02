# acme setup

These scripts are aimed to help with free TLS certs setup.
They are based on `uacme` client that talks to https://letsencrypt.org/ by default.

> :warning:  **Treat these scripts more like a reference implementation and/or building blocks.** :warning:
>
> The particular setup still should be customised as it hugely depends on your web server of choice and your server configuration.

## Main components
 * `docker`
 * `cron`
 * `uacme`

## Usage

```bash

# after running you've got cert and key files:
# /etc/ssl/uacme/<your-domain>/cert.pem
# /etc/ssl/uacme/private/<your-domain>/key.pem
```
