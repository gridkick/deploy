App.machine_configs.register 'mysql' do | base_config |
  base_config.vm.define :mysql do | config |
    config.vm.hostname = 'gridkick-mysql-server'

    config.vm.network \
      :forwarded_port,
      :guest => 22,
      :host  => App.seeds[ 'mysql' ][ 'ansible_ssh_port' ]

    config.vm.network \
      :forwarded_port,
      :guest => App.seeds[ 'mysql' ][ 'app_db_port' ],
      :host  => App.seeds[ 'mysql' ][ 'vm_db_forwarded_port' ]

    config.vm.provision :ansible do | ansible |
      ansible.extra_vars     = App.seeds[ 'mysql' ]
      ansible.inventory_path = 'hosts/local.hosts'
      ansible.playbook       = 'mysql.yml'
      ansible.verbose        = true
    end
  end
end
