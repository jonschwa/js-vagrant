# The Jon Schwartz approved Vagrant setup:

This is a vagrant starter kit. Provisioning will install:

`
nginx,php,node,gulp,ruby,mysql,composer`
 
## Prerequisites:

Install [Virtual Box](https://www.virtualbox.org/) & [Vagrant](https://www.vagrantup.com/downloads.html)

## Instructions:

Clone this repo anywhere you'd like! I like it in my ~ dir (and these instructions will assume you cloned there), but you are a responsible adult and can do whatever the hell you want. Check out any code you want on the vm into the /Code folder.


#### To start your VM: 

`$ cd ~/[dir_of_choice]/Vagrant`

`$ vagrant up`

And that's it! The provisioning script will run and you will have a fresh VM with Ubuntu 14.04, mysql, php, node, apache, and ruby installed. 

If you go to 192.168.10.32 you should see the default nginx page.

The best part is that you can simply modify your local files in the /Code directory and they will automatically be synced to the remote ~/Code folder on your VM. How cool is that?

#### To ssh into your VM: 

`$ cd ~/[dir_of_choice]/Vagrant`

`$ vagrant ssh`


#### To stop your VM
`$ cd ~/[dir_of_choice]/Vagrant`

`$ vagrant halt`


#### Other Configuration

The provisioning script can be re-run by typing `vagrant provision` from within ~/[dir_of_choice]/Vagrant.

#### mySQL

If you want to connect to your VM's mysql server with sequel pro, you can ssh in as vagrant@192.168.10.32 with the key file located at ~/wpd-vagrant/Vagrant/.vagrant/machines/default/virtualbox/private_key.
The mySQL host is 127.0.0.1, username is 'root', pw is 'abc123'.

#### If you seriously mess up or otherwise incapacitate your VM
Fear not! These are totally disposable. You can completely destroy your VM by typing 

`$ cd ~/[dir_of_choice]/ubuntu`

`$ vagrant destroy`

#### To set up a Wordpress Site:

Clone the Wordpress site into the /Code/ directory. Nginx is automatically configured so that <$url>.wp.local will automatically 
point to /home/vagrant/Code/<$url>. Once you have done this, simply create a db: 

```sh
$ mysql -uroot -pabc123

mysql> create database [dbname];
mysql> exit;
```
and then go through the Wordpress installation. 


#### To set up a Laravel app:

Clone your app into the /Code/ directory and then composer install. The vhosts are set so that <url>.laravel.local will point to
/home/vagrant/Code/<$url>/public and the permissions are all set!

#### Need to set up custom nginx configs?

It's easy! Just create a new config in the Vagrant/provision/nginx folder and reprovision your vm
`$ cd ~/[dir_of_choice]/Vagrant`

`$ vagrant provision`