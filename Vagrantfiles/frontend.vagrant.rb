App.machine_configs.register 'frontend' do | base_config |
  base_config.vm.define :frontend do | config |
    config.vm.hostname = 'adventure-frontend-server'

    config.vm.network \
      :forwarded_port,
      :guest => 22,
      :host  => App.seeds[ 'frontend' ][ 'ansible_ssh_port' ]

    config.vm.network \
      :private_network,
      :ip => App.seeds[ 'frontend' ][ 'vagrant_ip_address' ]

    config.vm.provision :ansible do | ansible |
      ansible.extra_vars     = App.seeds[ 'frontend' ]
      ansible.inventory_path = 'hosts/local.hosts'
      ansible.playbook       = 'frontend.yml'
      ansible.verbose        = true
    end
  end
end
