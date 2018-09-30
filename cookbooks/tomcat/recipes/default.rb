#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# sudo yum install java-1.7.0-openjdk-devel
package 'java-1.7.0-openjdk-devel'

# sudo groupadd tomcat
group 'tomcat'

# sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
user 'tomcat' do
    manage_home false
    group 'tomcat'
    shell '/bin/nologin'
    home '/opt/tomcat'
end

# wget http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.0.53/bin/apache-tomcat-8.0.53.tar.gz
remote_file 'apache-tomcat-8.0.53.tar.gz' do
    source 'http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.0.53/bin/apache-tomcat-8.0.53.tar.gz'
end

# cd /opt/tomcat
# sudo chgrp -R tomcat /opt/tomcat
directory '/opt/tomcat' do
    action :create
    group 'tomcat'
end

# NOT DESIRED STATE
execute 'sudo tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'

# NOT DESIRED STATE
execute 'chgrp -R tomcat /opt/tomcat'

# NOT DESIRED STATE
execute 'chmod -R g+r /opt/tomcat/conf/*'

directory '/opt/tomcat/conf' do
    mode '0070'
end

# NOT DESIRED STATE
execute 'sudo chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/'

template '/etc/systemd/system/tomcat.service' do
    source 'tomcat.service.erb'
end

execute 'sudo systemctl daemon-reload'

service 'tomcat' do
    action [:enable, :start]
end
