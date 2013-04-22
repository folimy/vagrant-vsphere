require 'spec_helper'
require 'vSphere/action/connect_vsphere'

describe VagrantPlugins::VSphere::ConnectVSphere do
  before :each do
    described_class.new(@app, @env).call(@env)
  end

  it 'should connect to vSphere' do
    VIM.should have_received(:connect).with({
      :host => @env[:machine].provider_config.host,
      :user => @env[:machine].provider_config.user,
      :password => @env[:machine].provider_config.password
    })
  end

  it 'should add the vSphere connection to the environment' do
    @env[:vSphere_connection].should be @vim
  end

  it 'should call the next item in the middleware stack' do
    @app.should have_received :call
  end
end