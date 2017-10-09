# # encoding: utf-8

# Inspec test for recipe azurex2::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root') do
    it { should exist }
  end
end

# install-gui section
describe package('xfce4') do
  it { should be_installed }
end

describe package('xrdp') do
  it { should be_installed }
end
# /install-gui section

# install-samba section
describe package('samba') do
  it { should be_installed }
end

describe directory('/smbshare') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
  its('mode') { should eq 00777 }
end

# in its simplest form, this test will work without running the recipe
# the smb.conf will exist, but in a generic version.
# so this is a worthless test at this time
describe file('/etc/samba/smb.conf') do
  it { should exist }
end
# /install-samba section

# server-info section
describe package('apache2') do
  it { should be_installed }
end

describe file('/var/www/html/index.html') do
  it { should exist }
  its('content') { should eq '<h1>My home page</h1>
<a href="server-info.html">Link to server-info</a>' }
end

describe file('/var/www/html/server-info.html') do
  it { should exist }
end
# /server-info section

# packages = []
#
# # %w(net-tools php-common apache2).each do |item|
# %w(net-tools php-common).each do |item|
#   packages << item
# end
#
# packages.each do |pkg|
#   describe package(pkg) do
#     it { should be_installed }
#   end
# end
#
# case os[:family]
# when 'redhat'
#   describe package('httpd') do
#     it { should be_installed }
#   end
# when 'debian'
#   describe package('apache2') do
#     it { should be_installed }
#   end
# end
#
# describe directory('/var/www/html/page2') do
#   it { should exist }
# end
#
# describe file('/var/www/html/index.html') do
#   it { should exist }
# end
#
# describe file('/var/www/html/page2/page2.html') do
#   it { should exist }
# end
#
# describe file('/var/www/html/server-info.html') do
#   it { should exist }
# end
#
# %w(net-tools php-common).each do |item|
#   packages << item
# end
#
# case os[:family]
# when 'redhat'
#   packages << 'httpd'
# when 'debian'
#   packages << 'apache2'
# end
#
# packages.each do |pkg|
#   describe package(pkg) do
#     it { should be_installed }
#   end
# end

# this is an array of packages that should get installed
# 'puts' works here in that the array is printed in the output of a kitchen verify
# puts packages

# This is an example test, replace it with your own test.
# describe port(80) do
#   it { should be_listening }
# end