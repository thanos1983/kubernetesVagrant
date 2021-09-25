IMAGE_NAME = "bento/ubuntu-20.04"
N = 2

$script = <<-SCRIPT
echo I am updating all packages...
apt-get update
echo Upgrading all packages...
echo Remove dependencies after update / upgrade...
apt-get autoremove
echo Remove local repositories...
apt-get autoclean
SCRIPT

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
    end

    config.vm.define "k8s-master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network "private_network", ip: "192.168.50.10"
        master.vm.hostname = "k8s-master"
        master.vm.provision "shell", inline: $script
        master.vm.provision "ansible" do |ansible|
            ansible.compatibility_mode = "2.0"
            ansible.playbook = "kubernetes-playbooks/master-playbook.yml"
            ansible.extra_vars = {
                node_ip: "192.168.50.10",
                number_of_nodes: N + 1
            }
        end
    end

    config.vm.define "k8s-client-1" do |ingress|
        ingress.vm.box = IMAGE_NAME
        ingress.vm.network "private_network", ip: "192.168.50.11"
        ingress.vm.network "forwarded_port", guest: 30080, host: 30080
        ingress.vm.network "forwarded_port", guest: 30443, host: 30443
        ingress.vm.hostname = "k8s-client-1"
        ingress.vm.provision "shell", inline: $script
        ingress.vm.provision "ansible" do |ansible|
            ansible.compatibility_mode = "2.0"
            ansible.playbook = "kubernetes-playbooks/worker-playbook.yml"
            ansible.extra_vars = {
                node_ip: "192.168.50.11"
            }
        end
    end

    (2..N).each do |i|
        config.vm.define "k8s-client-#{i}" do |worker|
            worker.vm.box = IMAGE_NAME
            worker.vm.network "private_network", ip: "192.168.50.#{i + 10}"
            worker.vm.hostname = "k8s-client-#{i}"
            worker.vm.provision "shell", inline: $script
            worker.vm.provision "ansible" do |ansible|
                ansible.compatibility_mode = "2.0"
                ansible.playbook = "kubernetes-playbooks/worker-playbook.yml"
                ansible.extra_vars = {
                    node_ip: "192.168.50.#{i + 10}"
                }
            end
        end
    end
end
