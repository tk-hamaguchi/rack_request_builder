require 'spec_helper'

describe RackRequestBuilder do
  subject { described_class }

  context 'constants' do
    subject { super().const_get :VERSION }
    it 'has a version number' do
      is_expected.not_to be nil
    end
  end

  it { is_expected.to respond_to :execute }
  it { is_expected.to respond_to :env }
  context '.execute' do
    let(:http_data) {
      <<-'EOS'
POST /somepage.php HTTP/1.1
Host: example.com
Content-Type: application/x-www-form-urlencoded
Content-Length: 25

hoge=HOGE&fuga[moke]=MOKE
      EOS
    }
    subject { RackRequestBuilder.execute(http_data) }
    it { is_expected.to be_instance_of ::Rack::Request }

    context '#body' do
      subject { super().body }
      it { is_expected.to be_a StringIO }

      context '#read' do
        subject { super().read }
        it { is_expected.to eq 'hoge=HOGE&fuga[moke]=MOKE' }
      end
    end

    context '#content_type' do
      subject { super().content_type }
      it { is_expected.to eq 'application/x-www-form-urlencoded' }
    end

    context '#host' do
      subject { super().host }
      it { is_expected.to eq 'example.com' }
    end

    context '#params' do
      subject { super().params }
      it { is_expected.to include 'hoge' => 'HOGE' }
      it { is_expected.to include 'fuga' => a_kind_of(Hash) }
      it { is_expected.to include 'fuga' => { 'moke' => 'MOKE' } }
    end

    context '#path' do
      subject { super().path }
      it { is_expected.to eq '/somepage.php' }
    end

    context '#post?' do
      subject { super().post? }
      it { is_expected.to be_truthy }
    end

    context '#scheme' do
      subject { super().scheme }
      it { is_expected.to eq 'http' }
    end

    context '#url' do
      subject { super().url }
      it { is_expected.to eq 'http://example.com/somepage.php' }
    end
  end
end
