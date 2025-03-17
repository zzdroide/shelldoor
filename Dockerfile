FROM alpine:3.21
RUN apk add --no-cache \
  openssh \
  openssh-server-pam \
  google-authenticator \
  curl

# set -euxo pipefail
SHELL ["/bin/ash", "-o", "errexit", "-o", "nounset", "-o", "xtrace", "-o", "pipefail", "-c"]

COPY alpine_root/ /

ARG TOTP_SECRET HPASSWORD HOST_UID HOST_GID HOST_USER
RUN <<EOF
  addgroup -g "$HOST_GID" wetty
  adduser -D -u "$HOST_UID" -G wetty wetty
  echo "wetty:$HPASSWORD" | chpasswd -e
  (umask 377 && echo \
"$TOTP_SECRET
\" RATE_LIMIT 3 30
\" TOTP_AUTH
" >/home/wetty/.google_authenticator)
  chown wetty:wetty /home/wetty/.google_authenticator
  ssh-keygen -A
  echo "ForceCommand ssh $HOST_USER@host.docker.internal" >>/etc/ssh/sshd_config
EOF

CMD ["/usr/sbin/sshd.pam", "-D"]
