#
# Cookbook:: azurex2
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'azurex2::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'installs samba' do
      expect(chef_run).to install_package('samba')
    end

    # This code works to test the installation of each element of an array
    packages = []

    %w(net-tools php-common apache2).each do |item|
      packages << item
    end

    packages.each do |pkg|
      it 'installs apache2' do
        expect(chef_run).to install_package(pkg)
      end
    end

    it 'creates a directory' do
      expect(chef_run).to create_directory('/var/www/html/page2')
    end

    it 'creates the file index.html' do
      expect(chef_run).to create_cookbook_file('/var/www/html/index.html')
    end

    it 'creates the file page2.html' do
      expect(chef_run).to create_file('/var/www/html/page2/page2.html')
    end


    it 'creates a template for server-infor.html' do
      expect(chef_run).to create_template('/var/www/html/server-info.html')
    end

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

