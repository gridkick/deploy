App.machine_configs.register 'api' do | base_config |
  base_config.vm.define :api do | config |
    config.vm.hostname = 'gridkick-api-server'

    config.vm.network \
      :forwarded_port,
      :guest => 22,
      :host  => App.seeds[ 'api' ][ 'ansible_ssh_port' ]

    config.vm.network \
      :private_network,
      :ip => App.seeds[ 'api' ][ 'vagrant_ip_address' ]

    config.vm.provision :ansible do | ansible |
      ansible.extra_vars     = App.seeds[ 'api' ]
      ansible.inventory_path = 'hosts/local.hosts'
      ansible.playbook       = 'core.yml'
      ansible.verbose        = true
    end
  end
end
