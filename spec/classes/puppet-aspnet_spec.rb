require 'spec_helper'

supported_oses = {}.merge!(on_supported_os)
RspecPuppetFacts.meta_supported_os.each do |os|
  if os['operatingsystem'] =~ /windows/i
    os['operatingsystemrelease'].each do |release|
      os_string = "#{os['operatingsystem']}-#{release}"
      supported_oses[os_string] = {
        :operatingsystem => 'windows',
        :kernelversion => '6.3.9600', # Just defaulting to 2012r2
      }
    end
  end
end

describe 'puppet-aspnet' do
  context 'supported operating systems' do
    supported_oses.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context 'without any parameters' do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('puppet-aspnet::params') }
          it { is_expected.to contain_class('puppet-aspnet::install').that_comes_before('puppet-aspnet::config') }
          it { is_expected.to contain_class('puppet-aspnet::config') }
          it { is_expected.to contain_class('puppet-aspnet::service').that_subscribes_to('puppet-aspnet::config') }

          it { is_expected.to contain_service('puppet-aspnet') }
          it { is_expected.to contain_package('puppet-aspnet').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('puppet-aspnet') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
