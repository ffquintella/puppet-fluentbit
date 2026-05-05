require 'spec_helper'

describe 'fluentbit::repo' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end

  context 'on RedHat 10' do
    let(:facts) do
      {
        os: {
          architecture: 'x86_64',
          distro: {
            id: 'RedHat',
          },
          family: 'RedHat',
          name: 'RedHat',
          release: {
            full: '10.0',
            major: '10',
          },
        },
      }
    end

    it { is_expected.to compile }
    it { is_expected.to contain_yumrepo('fluentbit').with_baseurl('https://packages.fluentbit.io/centos/10') }
  end
end
