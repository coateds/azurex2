#
# Cookbook:: azurex2
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# find examples here:  https://github.com/chefspec/chefspec

require 'spec_helper'

describe 'azurex2::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end


    it 'expands the run_list' do
      expect(chef_run).to include_recipe('ubuntu-installation-recipes::install-gui')
      expect(chef_run).to include_recipe('ubuntu-installation-recipes::install-samba')
      expect(chef_run).to include_recipe('ubuntu-installation-recipes::server-info-web')
      #expect(chef_run).to_not include_recipe('roles::not_recipe')
    end

    # install-gui section
    it 'updates apt repo' do
      expect(chef_run).to update_apt_update('update_repo')
    end

    it 'installs xfce4' do
      expect(chef_run).to install_package('xfce4')
    end

    it 'installs xrdp' do
      expect(chef_run).to install_package('xrdp')
    end
    # /install-gui section

    # install-samba section
    it 'installs samba' do
      expect(chef_run).to install_package('samba')
    end

    it 'creates the /samba directory with attributes' do
      expect(chef_run).to create_directory('/smbshare').with(
        owner:  'root',
        group:  'root',
        mode:   '0777'
      )
    end

    it 'creates the file smb.conf' do
      expect(chef_run).to create_cookbook_file('/etc/samba/smb.conf')
    end
    # /install-samba section

    # server-info section
    # 1) Install a web server (apache2)
    # case "#{node['platform_family']}"
    #   when 'redhat'
    #     package 'httpd'
    #   when 'debian'
    #     package 'apache2'
    # end
    it 'installs apache2' do
      expect(chef_run).to install_package('apache2')
    end

    it 'creates the index.html file with attributes' do
      expect(chef_run).to create_file('/var/www/html/index.html').with(
        content:  '<h1>My home page</h1>
<a href="server-info.html">Link to server-info</a>'
      )
    end

    it 'creates a template for server-info.html' do
      expect(chef_run).to create_template('/var/www/html/server-info.html')
    end
    # /server-info section

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end



    # This is the brute force way to program this
    #it 'installs net-tools' do
    #  expect(chef_run).to install_package('net-tools')
    #end

    #it 'installs php-common' do
    #  expect(chef_run).to install_package('php-common')
    #end

    #it 'installs apache2' do
    #  expect(chef_run).to install_package('apache2')
    #end

    # case "#{node['platform_family']}"
    # when 'redhat'
    #   #packages << 'httpd'
    #   puts 'httpd'
    # when 'debian'
    #   #packages << 'apache2'
    #   puts 'apache2'
    # end

    # It is possible to see arbitrary output
    #puts "Goober"

    # But I cannot seem to retrieve a Fauxhai value to test
    # puts node['platform_family']
#

#
#    # This code works to test the installation of each element of an array
#    packages = []
#
#    %w(net-tools php-common apache2).each do |item|
#      packages << item
#    end
#
#    packages.each do |pkg|
#      it 'installs apache2' do
#        expect(chef_run).to install_package(pkg)
#      end
#    end
#
#    it 'creates a directory' do
#      expect(chef_run).to create_directory('/var/www/html/page2')
#    end
#
#    it 'creates the file index.html' do
#      expect(chef_run).to create_cookbook_file('/var/www/html/index.html')
#    end
#
#    it 'creates the file page2.html' do
#      expect(chef_run).to create_file('/var/www/html/page2/page2.html')
#    end
#
#

#