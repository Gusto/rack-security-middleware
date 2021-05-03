require 'spec_helper'
require 'rack-security-middleware/block_path_traversal'

RSpec.describe RackSecurityMiddleware::BlockPathTraversal do
  let(:app) do
    Class.new do
      attr_reader :request

      def call(env)
        @request = ActionDispatch::Request.new(env)
        [200, { 'Content-Type' => 'text/plain' }, ['OK']]
      end
    end
  end

  let(:stack) { described_class.new(app.new) }
  let(:request) { Rack::MockRequest.new(stack) }

  describe '.call' do
    it 'does not affect normal calls' do
      response = request.get('/')

      expect(response.status).to eq(200)
    end

    it 'blocks calls trying path traversal' do
      response = request.get('/../root/passwords')

      expect(response.status).to eq(403)
    end

    # this could catch things that are not path traversals
    # but there are all kinds of variations like %c1%9c.. or %252f.. or x5Cx5Cx5C.. etc
    # and a legit use case for .. in the middle of a section of the path is arguable
    # so we chose to be more aggressive and safer here
    it 'blocks calls with .. but not /' do
      response = request.get('/ohno..root/passwords')

      expect(response.status).to eq(403)
    end
  end
end
