require 'spec_helper'

shared_examples_for "base case" do
  it { is_expected.to compile.with_all_deps }

  it { is_expected.to contain_class('autosign::params') }
  it { is_expected.to contain_class('autosign::install').that_comes_before('autosign::config') }
  it { is_expected.to contain_class('autosign::config') }
end

PuppetSpecFacts.facts_for_platform_by_name(["Debian_wheezy_7.7_amd64_3.7.2_structured"]).each do |name, facthash|
  describe 'autosign' do
    let(:facts) { facthash }
    context "autosign class without any parameters" do
      let(:params) {{ }}

      it_behaves_like "base case"

      it { is_expected.to contain_package('autosign').with_ensure('present') }
    end

    context "autosign class with some parameters" do
      let(:params) {{
        :ensure   => 'latest',
        :settings => { 'jwt_token' => { 'secret' => 'hunter2' } },
      }}
      it_behaves_like "base case"

      it { is_expected.to contain_package('autosign').with_ensure('latest') }
      it { is_expected.to contain_file('/etc/autosign.conf') }
      it { is_expected.to contain_file('/var/lib/autosign') }
    end

    context 'unsupported operating system' do
      describe 'autosign class without any parameters on Solaris/Nexenta' do
        let(:facts) {{
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }}

        it { expect { is_expected.to contain_package('autosign') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
      end
    end
  end
end
