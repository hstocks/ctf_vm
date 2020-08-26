# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.ssh.username = "vagrant"
  config.ssh.forward_agent = true
  config.vm.provision :shell, :path => "vagrant_setup.sh", :privileged => false

  memory = "4096"

  config.vm.define "pwn_1604", primary: true do |u64|
    u64.vm.network "private_network", ip: "10.10.10.10"
    u64.vm.provider "virtualbox" do |vb, override|
      override.vm.box ="generic/ubuntu1604"
      override.vm.network :forwarded_port, guest: 22, host: 40421
      vb.customize ["modifyvm", :id, "--memory", "4096"]
       vb.customize ["modifyvm", :id, "--cpus", "8"]
      override.vm.synced_folder ".", "/vagrant/"
      vb.name = "pwn_1604"
      vb.memory = memory
      vb.gui = false
    end
  end

  config.vm.define "pwn_1804", primary: true do |u64|
    #u64.vm.network "private_network", ip: "10.10.10.10"
    u64.vm.network "private_network", type: "dhcp"
    u64.vm.provider "virtualbox" do |vb, override|
      override.vm.box ="generic/ubuntu1804"
      override.vm.network :forwarded_port, guest: 22, host: 40422
      override.vm.synced_folder ".", "/vagrant/"
      vb.name = "pwn_1804"
      vb.memory = memory
      vb.gui = false
    end
  end

  config.vm.define "pwn_1904", primary: true do |u64|
    u64.vm.network "private_network", ip: "10.10.10.10"
    u64.vm.provider "virtualbox" do |vb, override|
      override.vm.box ="generic/ubuntu1904"
      override.vm.network :forwarded_port, guest: 22, host: 40423
      override.vm.synced_folder ".", "/vagrant/"
      vb.name = "pwn_1904"
      vb.memory = memory
      vb.gui = false
    end
  end
end
