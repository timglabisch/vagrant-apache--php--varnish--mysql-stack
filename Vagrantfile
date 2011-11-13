Vagrant::Config.run do |config|
	config.vm.define :apache do |apache_config|
		apache_config.vm.box = "lucid64"
		config.vm.box_url = "http://files.vagrantup.com/lucid64.box"
		apache_config.vm.boot_mode = :gui
		apache_config.vm.provision :shell, :inline => "sudo apt-get update"
		apache_config.vm.forward_port "http", 80, 8080
		apache_config.vm.forward_port "varnish", 81, 8081
		apache_config.vm.forward_port "varnish_conf", 2000, 12000
		apache_config.vm.forward_port "mysql", 3306, 13306
		
		apache_config.vm.provision :puppet do |puppet|
		 puppet.manifests_path = "manifests"
		 puppet.manifest_file  = "apache.pp"
		end
		
		apache_config.vm.provision :puppet do |puppet|
		 puppet.manifests_path = "manifests"
		 puppet.manifest_file  = "mysql.pp"
		end

		apache_config.vm.provision :puppet do |puppet|
		 puppet.manifests_path = "manifests"
		 puppet.manifest_file  = "varnish.pp"
		end
		
		apache_config.vm.share_folder "./apache/var/www", "/var/www/", "apache/var/www/"
		#config.vm.provision :shell, :inline => "sudo service apache2 restart"
	end
end
