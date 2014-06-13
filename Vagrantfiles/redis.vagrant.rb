App.machine_configs.register 'redis' do | base_config |
  base_config.vm.define :redis do | config |
    config.vm.hostname = 'gridkick-redis-server'

    config.vm.network \
      :forwarded_port,
      :guest => 22,
      :host  => App.seeds[ 'redis' ][ 'ansible_ssh_port' ]
    
    config.vm.network \
      :private_network,
      :ip => App.seeds['redis']['vagrant_ip_address']
      
    config.vm.provision :ansible do | ansible |
      ansible.extra_vars     = App.seeds[ 'redis' ]
      ansible.inventory_path = 'hosts/local.hosts'
      ansible.playbook       = 'redis.yml'
      ansible.verbose        = true
    end
  end
end
