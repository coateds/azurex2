#
# Cookbook:: azurex2
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# The samba package does not seem to want to install without fetching updates first
#apt_update
#package 'samba'
include_recipe 'install-samba::default'

# This is the brute force way to install three packages
# package 'net-tools'
# package 'php-common'
# package 'apache2'

# This is better, assuming no need for logic to decide which packages to install based on attributes
# %w(net-tools php-common apache2).each do |item|
%w(net-tools php-common).each do |item|
    # Debug: puts item
    package item
end

# package 'apache2' do
#   action :remove
# end

case node['platform_family']
when 'redhat'
  package 'httpd'
when 'debian'
  package 'apache2'
end

# Here is how select Ohai attributes can be called
# puts node['hostname']
# puts node['os']
# puts node['platform_family']

# packages = []
#
# %w(net-tools php-common).each do |item|
#   packages << item
# end
#
# case node['platform_family']
# when 'redhat'
#   packages << 'httpd'
# when 'debian'
#   packages << 'apache2'
# end
#
# packages.each do |pkg|
#     package pkg
# end

# This will copy the file from the scaffolding
cookbook_file '/var/www/html/index.html' do
  source 'index.html'
end

# Create a directory
directory '/var/www/html/page2'

# This will simply create a blank file with content
file '/var/www/html/page2/page2.html' do
  content '<html>This is page 2<html>'
end

# This will create a file with Ohai/Fauxhai attributes expanded
template '/var/www/html/server-info.html' do
  source 'server-info.html.erb'
end

#### A couple of blocks for appending a line if it does not exist
#### All three append the line
#### The last one seems to be idempotent
#bash "insert_line" do
#user "root"
#code <<-EOS
#echo "172.22.0.47    www.example.com" >> /etc/hosts
#EOS
#not_if "grep -q www.example.com /etc/hosts"
#end

#ruby_block "insert_line" do
#block do
#file = Chef::Util::FileEdit.new("/etc/hosts")
#file.insert_line_if_no_match("/www.example.com/", "www.example.com")
#file.write_file
#end
#end

#line = 'samba'
#file = Chef::Util::FileEdit.new('/etc/hosts')
#file.insert_line_if_no_match(/#{line}/, line)
#file.write_file
#### /append line