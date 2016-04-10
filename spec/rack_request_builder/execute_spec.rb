require 'spec_helper'

describe RackRequestBuilder::Execute do
  subject { RackRequestBuilder::Execute }

  let(:included) do
    Module.new do
      include described_class
    end
  end

  it { is_expected.to respond_to :execute }

  context 'included module' do
    it { is_expected.to respond_to :execute }
  end

  context '#execute' do
    let(:http_data) { "GET /forums/1/topics/2375?page=1#posts-17408 HTTP/1.1\r\n\r\n" }
    let(:env) { double }
    let(:request) { double }
    before do
      allow(described_class).to receive(:env) { env }
      allow(::Rack::Request).to receive(:new) { request }
    end

    subject { super().execute(http_data) }

    it { is_expected.to eq request }
    it do
      expect(described_class).to receive(:env).once
      subject
    end
    it do
      expect(::Rack::Request).to receive(:new).with(env).once
      subject
    end
  end
end
