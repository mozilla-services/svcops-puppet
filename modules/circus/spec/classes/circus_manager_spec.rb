require 'spec_helper'

describe 'circus::manager' do

  it do
    should contain_file('/etc/circus.ini') \
        .with_content(/check_delay = 5/)
  end

  # test the defaults work
  it do
    should contain_package('circus').with({
            'ensure' => '0.8.1-1',
            'alias'  => 'circus'
    })
  end

  context 'with custom package and version' do
    let(:params) { {:circus_package => 'python-circus', :circus_version => 'latest' } }
    
    it do
      should contain_package('python-circus').with({
        'ensure' => 'latest',
        'alias'  => 'circus'
      })
    end
  end
end
