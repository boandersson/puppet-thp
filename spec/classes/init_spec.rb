require 'spec_helper'

describe 'thp' do
  describe 'config' do
    context 'defaults on RHEL6' do
      let :facts do
        {
          :kernel            => 'Linux',
          :osfamily          => 'RedHat',
          :lsbmajdistrelease => '6'
        }
      end

      it { should contain_service('thp_service').with({'ensure' => 'stopped'}) }
      it { should contain_service('thp_service').with({'enable' => true }) }

      it do
        should contain_file('thp_initd_path').with({
          'owner' => 'root',
          'group' => 'root',
          'mode'  => '0755'
        })
      end

      it do 
        should contain_file('thp_sysconfig_path').with({
          'owner' => 'root',
          'group' => 'root',
          'mode'  => '0644'
        })
      end
      it { should contain_file('thp_sysconfig_path').with_content(/^THP=always/) }
      it { should contain_file('thp_sysconfig_path').with_content(/^THP_DEFRAG=always/) }
    end

    context 'disable service and config' do
      let :facts do
        {
          :kernel            => 'Linux',
          :osfamily          => 'RedHat',
          :lsbmajdistrelease => '6',
        }
      end

      let :params do
        { 
          :service_enable    => 'false',
          :service_ensure    => 'stopped',
          :thp_status        => 'never',
          :thp_defrag_status => 'never',
        }
      end

      it { should contain_service('thp_service').with({'enable' => false }) }
      it { should contain_service('thp_service').with({'ensure' => 'stopped' }) }
      it { should contain_file('thp_sysconfig_path').with_content(/^THP=never/) }
      it { should contain_file('thp_sysconfig_path').with_content(/^THP_DEFRAG=never/) }
    end
  end

  describe 'OS support' do
    context 'doesnt support RHEL5' do
      let :facts do
        {
          :kernel            => 'Linux',
          :osfamily          => 'RedHat',
          :lsbmajdistrelease => '5',
        }
      end

      it 'should fail with error' do
        expect {
          should contain_file('thp_initd_path')
        }.to raise_error(Puppet::Error, /does not have Transparent Huge Page support/)
      end
    end

    context 'doesnt support RHEL7' do
      let :facts do
        {
          :kernel            => 'Linux',
          :osfamily          => 'RedHat',
          :lsbmajdistrelease => '7',
        }
      end

      it 'should fail with error' do
        expect {
          should contain_file('thp_initd_path')
        }.to raise_error(Puppet::Error, /RedHat 7 currently unsupported/)
      end
    end
  end
end