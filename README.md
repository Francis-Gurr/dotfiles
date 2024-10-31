# .dotfiles

Configurations for all my tools.

Each directory includes a `playbook.yml` file that will install the tool and any dependencies and stow the configuration.
These playbooks are currently arch specific.

run them using: `ansible-playbook -K dir/playbook.yml`
or run the `main.yml` playbook to setup all tools `main.yml`
