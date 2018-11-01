#
# Cookbook:: node-server
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'node-server::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should install nginx' do
      expect(chef_run).to install_package 'nginx'
    end

    it 'should enable the nginx service' do
      expect(chef_run).to enable_service 'nginx'
    end

    it 'should start the nginx service' do
      expect(chef_run).to start_service 'nginx'
    end

    it 'should create the default nginx template' do
      expect(chef_run).to create_template('/etc/nginx/sites-available/default')
    end

    it "should restart the nginx service on template change" do
      template = chef_run.template('/etc/nginx/sites-available/default')
      expect(template).to notify('service[nginx]').to(:reload)
    end

    it "should install nodejs from a recipe" do
      expect(chef_run).to include_recipe("nodejs")
    end

    it 'should install pm2 via npm' do
      expect(chef_run).to install_nodejs_npm('pm2')
    end
  end
end
