# -*- mode: ruby -*-
# vi: set ft=ruby :

load 'lib/app.rb'

Vagrant.configure( '2' ) do | config |
  config.vm.box     = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'

  config.vm.provider :virtualbox do | vb |
    vb.customize [
      'modifyvm',
      :id,
      '--memory',
      '512'
    ]
  end

  App.load_seeds!
  App.load_machine_configs! config
end
