If you want to be sure that your server wasn't hacked, the alerts have to be logged in a different server of course.

This is the simplest log recorder I could think of: TCP with netcat writing to a file.

Nginx is used as reverse proxy, which provides TLS and basic auth.
