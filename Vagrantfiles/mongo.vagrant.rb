App.machine_configs.register 'mongo' do | base_config |
  base_config.vm.define :mongo do | config |
    config.vm.hostname = 'gridkick-mongo-server'

    config.vm.network \
      :forwarded_port,
      :guest => 22,
      :host  => App.seeds[ 'mongo' ][ 'ansible_ssh_port' ]
    
    config.vm.network \
      :private_network,
      :ip => App.seeds['mongo']['vagrant_ip_address']
      
    config.vm.provision :ansible do | ansible |
      ansible.extra_vars     = App.seeds[ 'mongo' ]
      ansible.inventory_path = 'hosts/local.hosts'
      ansible.playbook       = 'mongo.yml'
      ansible.verbose        = true
    end
  end
end
