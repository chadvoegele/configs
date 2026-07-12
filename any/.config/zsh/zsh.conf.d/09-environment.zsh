if [ -x /usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator ]; then
    emulate zsh -o all_export -c 'source <(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)'
fi
