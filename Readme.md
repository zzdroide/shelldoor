# Shelldoor

Ever wanted to ssh into your server, but the only device you had was a friend's computer or phone? With this project running in your server, and with access to your cloud password manager and/or memorized password, now you can.

## Features

- Uses [WeTTY](https://github.com/butlerx/wetty) for http to ssh

- An intermediate ssh server asks for password and 2FA (TOTP)

- As this is a bit scary, on successful login the server alerts you.
  > For example to Telegram, and for extra paranoia (stolen phone?) also logs to another server.

- If you only have quick access to your TOTP secret but not to a tool to generate a code, a barebones generator is provided at [/totp](https://shelldoor.zzdroide.cl/totp)
  > It's ugly and cpu-inefficient, but it's not much code so it's easy to audit.
  >
  > A nicer alternative is to self-host [Dan Hersam's](https://totp.danhersam.com/) generator instead.

## Setup

- Clone this repo in your server

- Copy .example.env to .env and edit it

- Ensure you can `ssh localhost` in your server
  > If it doesn't work:
  > ```sh
  > ssh-keygen -t ed25519
  > cat ~/.ssh/id_ed25519.pub >>~/.ssh/authorized_keys
  > ```

- Optional: copy `alert_example` to `alert` and code your desired alert method

- Start containers with docker compose

- Copy nginx_site.conf to /etc/nginx/sites_enabled/shelldoor. Edit it and run certbot.
