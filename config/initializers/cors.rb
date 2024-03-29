Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3000', '127.0.0.1:3000', 'https://han-react.netlify.app', 'localhost:3001'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end
end
