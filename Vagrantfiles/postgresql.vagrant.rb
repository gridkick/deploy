App.machine_configs.register 'postgresql' do | base_config |
  base_config.vm.define :postgresql do | config |
    config.vm.hostname = 'gridkick-postgresql-server'

    config.vm.network \
      :forwarded_port,
      :guest => 22,
      :host  => App.seeds[ 'postgresql' ][ 'ansible_ssh_port' ]

    config.vm.network \
      :forwarded_port,
      :guest => App.seeds[ 'postgresql' ][ 'app_db_port' ],
      :host  => App.seeds[ 'postgresql' ][ 'vm_db_forwarded_port' ]

    config.vm.provision :ansible do | ansible |
      ansible.extra_vars     = App.seeds[ 'postgresql' ]
      ansible.inventory_path = 'hosts/local.hosts'
      ansible.playbook       = 'postgresql.yml'
      ansible.verbose        = true
    end
  end
end
