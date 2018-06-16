if ENV['MEMCACHEDCLOUD_SERVERS']
  Rails.application.config.session_store ActionDispatch::Session::CacheStore, cache: ActiveSupport::Cache::MemCacheStore.new((ENV['MEMCACHEDCLOUD_SERVERS'] || '').split(','), { username: ENV['MEMCACHEDCLOUD_USERNAME'], password: ENV['MEMCACHEDCLOUD_PASSWORD'], failover: true, socket_timeout: 1.5, socket_failure_delay: 0.2, down_retry_delay: 60 })
end
