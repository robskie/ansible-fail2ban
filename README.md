# Ansible Role: Fail2Ban

This role installs and configures the latest Fail2Ban stable version from
source. This has been tested on Debian and Ubuntu Linux systems.

## Requirements

None.

## Role Variables

The available role variables are listed below along with their default values.

    fail2ban_version: 0.9.4

This is the version of Fail2Ban to be installed.

    fail2ban_config_file: ''
    fail2ban_jail_file: ''

These are the paths where the main and jail configuration files reside. This
will be copied to the remote host as `/etc/fail2ban/fail2ban.local` and
`/etc/fail2ban/jail.local`.

    fail2ban_filter_dir: ''
    fail2ban_action_dir: ''
    fail2ban_jail_dir: ''

The local path to filter, action, and jail configuration directories relative
to the playbook directory. The contents of these directories will be copied to
`/etc/fail2ban/filter.d/`, `/etc/fail2ban/action.d/`,
and `/etc/fail2ban/jail.d/`.

    fail2ban_clear_jails: no

If set to `yes`, old files in the jail directory (`/etc/fail2ban/jail.d`) will
be deleted before any configuration file is added.

    fail2ban_jails:
      - name: ssh
        enabled: yes
        port: 22
        protocol: tcp
        filter: sshd
        bantime: 600
        findtime: 600
        maxretry: 3
        action: action_mw
        logpath: /var/log/auth.log
        banaction: iptables-multiport

This is an example that shows all the available options for the `fail2ban_jails`
role variable. Note that the `action` and `logpath` parameters can be a string
or a list.

## Tags

  - fail2ban
  - install
  - configure
  - fail2ban:install
  - fail2ban:configure

## Dependencies

None.

## Example Playbook

    ---
    hosts: servers
    become: yes
    roles:
      - role: robskie.fail2ban
        fail2ban_jail_file: files/jail-default.conf
        fail2ban_filter_dir: files/filters/
        fail2ban_jails:
          - name: ssh
            enabled: yes
            port: ssh
            filter: sshd
            logpath: /var/log/auth.log
            maxretry: 3

## License

MIT
