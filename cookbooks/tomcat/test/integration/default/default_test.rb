# # encoding: utf-8

# Inspec test for recipe tomcat::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe command('curl https://localhost:8080') do
  its('stdout') { should match /Tomcat/ }
end

describe package('java-1.7.0-openjdk-devel') do
  it { should be_installed }
end

describe group('tomcat') do
  it { should exist }
end

describe user('tomcat') do
  it { should exist }
  its ('group') { should eq 'tomcat' }
  it { should have_login_shell '/bin/nologin' }
  it { should have_home_directory '/opt/tomcat' }
end

describe file('/opt/tomcat') do
  it { should exist }
  it { should be_directory }
end

describe file('/opt/tomcat/conf') do
    it { should exist }
    it { should be_directory }
    its('mode') { should eq '0070' }
end

%w( /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/ ).each do |dir|
    describe file(dir) do
        it { should exist }
        it { should be_directory }
        it { should be_owned_by 'tomcat' }
    end
end

describe service('tomcat') do
    it { should be_enabled }
    it { should be_running }
end
# This is an example test, replace it with your own test.
describe port(80), :skip do
  it { should_not be_listening }
end
