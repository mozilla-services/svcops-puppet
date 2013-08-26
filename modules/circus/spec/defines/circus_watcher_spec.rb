require 'spec_helper'

describe 'circus::watcher' do

  let(:title)  { 'nginx' }
  let(:params) {{ :cmd => '/bin/false', :args => 'I am false' }}

  it { should include_class('circus::manager') }

  it do
    should contain_file('/etc/circus.d/nginx.ini') \
        .with_content(/cmd = \/bin\/false/)
  end

  # check priority branch
  context 'with priority => 6' do
    let(:params) {{ :cmd => '/bin/false', :args => 'I am false', :priority => 6 }}

    it do
      should contain_file('/etc/circus.d/nginx.ini') \
        .with_content(/priority = 6/)
    end
  end
end
