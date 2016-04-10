require 'spec_helper'

describe RackRequestBuilder::Rack do
  subject { RackRequestBuilder::Rack }

  let(:included) do
    Module.new do
      include described_class
    end
  end

  context 'constants' do
    context 'RACK_VERSION' do
      subject { super().const_get :RACK_VERSION }
      it { is_expected.to eq 'rack.version' }
    end

    context 'RACK_INPUT' do
      subject { super().const_get :RACK_INPUT }
      it { is_expected.to eq 'rack.input' }
    end

    context 'RACK_ERRORS' do
      subject { super().const_get :RACK_ERRORS }
      it { is_expected.to eq 'rack.errors' }
    end

    context 'RACK_MULTITHREAD' do
      subject { super().const_get :RACK_MULTITHREAD }
      it { is_expected.to eq 'rack.multithread' }
    end

    context 'RACK_MULTIPROCESS' do
      subject { super().const_get :RACK_MULTIPROCESS }
      it { is_expected.to eq 'rack.multiprocess' }
    end

    context 'RACK_RUNONCE' do
      subject { super().const_get :RACK_RUNONCE }
      it { is_expected.to eq 'rack.run_once' }
    end

    context 'RACK_URL_SCHEME' do
      subject { super().const_get :RACK_URL_SCHEME }
      it { is_expected.to eq 'rack.url_scheme' }
    end

    context 'RACK_IS_HIJACK' do
      subject { super().const_get :RACK_IS_HIJACK }
      it { is_expected.to eq 'rack.hijack?' }
    end

    context 'RACK_HIJACK' do
      subject { super().const_get :RACK_HIJACK }
      it { is_expected.to eq 'rack.hijack' }
    end

    context 'RACK_HIJACK_IO' do
      subject { super().const_get :RACK_HIJACK_IO }
      it { is_expected.to eq 'rack.hijack_io' }
    end

    context 'QUERY_STRING' do
      subject { super().const_get :QUERY_STRING }
      it { is_expected.to eq 'QUERY_STRING' }
    end

    context 'HTTP_VERSION' do
      subject { super().const_get :HTTP_VERSION }
      it { is_expected.to eq 'HTTP_VERSION' }
    end

    context 'SERVER_PROTOCOL' do
      subject { super().const_get :SERVER_PROTOCOL }
      it { is_expected.to eq 'SERVER_PROTOCOL' }
    end

    context 'PATH_INFO' do
      subject { super().const_get :PATH_INFO }
      it { is_expected.to eq 'PATH_INFO' }
    end

    context 'SCRIPT_NAME' do
      subject { super().const_get :SCRIPT_NAME }
      it { is_expected.to eq 'SCRIPT_NAME' }
    end

    context 'REQUEST_PATH' do
      subject { super().const_get :REQUEST_PATH }
      it { is_expected.to eq 'REQUEST_PATH' }
    end
  end

  it { is_expected.to respond_to :env }

  context 'included module' do
    it { is_expected.to respond_to :env }
  end

  context '#env' do
    let(:path) { '/path/to/page' }
    let(:req) do
      double WEBrick::HTTPRequest,
        meta_vars: { :hoge => nil, 'SCRIPT_NAME' => '' },
        request_uri: double(path: path),
        body: StringIO.new('hogehoge=fuga&moke=puki')
    end

    subject { super().env(req) }
    it { is_expected.to include 'rack.version'      => a_kind_of(Array)    }
    it { is_expected.to include 'rack.input'        => a_kind_of(StringIO) }
    it { is_expected.to include 'rack.errors'       => a_kind_of(IO)       }
    it { is_expected.to include 'rack.hijack'       => a_kind_of(Proc)     }
    it { is_expected.to include 'rack.multithread'  => true   }
    it { is_expected.to include 'rack.multiprocess' => false  }
    it { is_expected.to include 'rack.run_once'     => false  }
    it { is_expected.to include 'rack.url_scheme'   => 'http' }
    it { is_expected.to include 'rack.hijack?'      => true   }
    it { is_expected.to include 'rack.hijack_io'    => nil    }
    it { is_expected.to include 'QUERY_STRING'      => ''     }
    it { is_expected.to include 'HTTP_VERSION'      => nil    }
    it { is_expected.to include 'PATH_INFO'         => path   }
    it { is_expected.to include 'SCRIPT_NAME'       => ''     }
    it { is_expected.to include 'REQUEST_PATH'      => path   }
    it { is_expected.to_not include 'hoge' }
  end
end
