# Inspired by https://github.com/sinatra/sinatra/blob/master/rack-protection/lib/rack/protection/path_traversal.rb
# but we want to completely block any abnormal url

module RackSecurityMiddleware
  class BlockPathTraversal
    def initialize(app)
      @app = app
    end

    def call(env)
      if has_path_traversal?(env['PATH_INFO'])
        [403, { 'Content-Type' => 'text/html' }, ['Forbidden']]
      else
        @app.call env
      end
    end

    private

    def has_path_traversal?(path)
      encoding = path.encoding
      dot = '.'.encode(encoding)
      unescaped = path.gsub(/%2e/i, dot)

      unescaped.include?("#{dot}#{dot}")
    end
  end
end
