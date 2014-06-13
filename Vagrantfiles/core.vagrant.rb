App.machine_configs.register 'core' do | base_config |
  base_config.vm.define :core do | config |
    config.vm.hostname = 'gridkick-core-server'

    config.vm.network \
      :forwarded_port,
      :guest => 22,
      :host  => App.seeds[ 'core' ][ 'ansible_ssh_port' ]

    config.vm.network \
      :private_network,
      :ip => '192.168.211.211'

    config.vm.provision :ansible do | ansible |
      ansible.extra_vars     = App.seeds[ 'core' ]
      ansible.inventory_path = 'hosts/local.hosts'
      ansible.playbook       = 'core.yml'
      ansible.verbose        = true
    end
  end
end
