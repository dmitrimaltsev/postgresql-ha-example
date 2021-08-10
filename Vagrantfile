Vagrant.configure("2") do |config|
    config.vm.define :manager do |manager|
        manager.vm.box = "ubuntu/focal64"
        manager.vm.network :private_network, ip: "192.168.50.100"
        manager.vm.hostname = "manager"
        manager.vm.provision "shell", path: "docker_setup.sh"
        manager.vm.provision "shell", inline: "docker swarm init --advertise-addr 192.168.50.100"
        manager.vm.provision "shell", inline: "docker swarm join-token -q worker > /vagrant/token"
        manager.vm.provision "shell", inline: "mkdir /home/vagrant/postgresql"
    end

    config.vm.define :worker1 do |worker1|
        worker1.vm.box = "ubuntu/focal64"
        worker1.vm.network :private_network, ip: "192.168.50.101"
        worker1.vm.network :forwarded_port, guest: 5432, host: 8432
        worker1.vm.hostname = "worker1"
        worker1.vm.provision "shell", path: "docker_setup.sh"
        worker1.vm.provision "shell", inline: "docker swarm join --token `cat /vagrant/token` 192.168.50.100:2377"
        worker1.vm.provision "shell", inline: "mkdir /home/vagrant/postgresql"
    end

    config.vm.define :worker2 do |worker2|
       worker2.vm.box = "ubuntu/focal64"
       worker2.vm.network :private_network, ip: "192.168.50.102"
       worker2.vm.network :forwarded_port, guest: 5433, host: 8433
       worker2.vm.hostname = "worker2"
       worker2.vm.provision "shell", path: "docker_setup.sh"
       worker2.vm.provision "shell", inline: "docker swarm join --token `cat /vagrant/token` 192.168.50.100:2377"
       worker2.vm.provision "shell", inline: "mkdir /home/vagrant/postgresql"
   end

    config.vm.define :worker3 do |worker3|
       worker3.vm.box = "ubuntu/focal64"
       worker3.vm.network :private_network, ip: "192.168.50.103"
       worker3.vm.network :forwarded_port, guest: 5434, host: 8434
       worker3.vm.hostname = "worker3"
       worker3.vm.provision "shell", path: "docker_setup.sh"
       worker3.vm.provision "shell", inline: "docker swarm join --token `cat /vagrant/token` 192.168.50.100:2377"
       worker3.vm.provision "shell", inline: "mkdir /home/vagrant/postgresql"
   end
end
