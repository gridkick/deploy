App.machine_configs.register 'ansible' do | base_config |
  base_config.vm.define :ansible do | config |
    config.vm.hostname = 'gridkick-ansible-server'

    config.vm.network \
      :forwarded_port,
      :guest => 22,
      :host  => App.seeds[ 'ansible' ][ 'ansible_ssh_port' ]

    config.vm.provision :ansible do | ansible |
      ansible.extra_vars     = App.seeds[ 'ansible' ]
      ansible.inventory_path = 'hosts/local.hosts'
      ansible.playbook       = 'ansible.yml'
      ansible.verbose        = true
    end
  end
end
