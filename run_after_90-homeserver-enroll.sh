#!/bin/sh
# Best-effort: register this machine on the homeserver when at home; never fails apply.
pub="$HOME/.ssh/id_ed25519.pub"

[ -f "$pub" ] || exit 0
command -v nc >/dev/null 2>&1 && ! nc -z -w2 homeserver 22 2>/dev/null && exit 0

# Stamp owner@device on the key so both authorized_keys entries stay auditable.
ssh-keygen -q -c -C "$(whoami)@$(hostname)" -f "${pub%.pub}" </dev/null >/dev/null 2>&1 || true

# Admin (user@): ssh-copy-id is idempotent; skip if the key already works.
ssh -o BatchMode=yes -o ConnectTimeout=5 homeserver true 2>/dev/null || ssh-copy-id homeserver || exit 0

# Git (git@): exit 255 = key not accepted yet; any other code = already enrolled.
ssh -o BatchMode=yes -o ConnectTimeout=5 homeserver-git true 2>/dev/null
[ $? -eq 255 ] || exit 0

echo "Enrolling $(whoami)@$(hostname) for git on the homeserver…"
key=$(cat "$pub")
ssh -t homeserver "sudo sh -c 'umask 077; mkdir -p /home/git/.ssh; grep -qxF \"$key\" /home/git/.ssh/authorized_keys 2>/dev/null || printf \"%s\\n\" \"$key\" >> /home/git/.ssh/authorized_keys; chown -R git:git /home/git/.ssh'" \
  || echo "git enrollment failed; add the key manually"
