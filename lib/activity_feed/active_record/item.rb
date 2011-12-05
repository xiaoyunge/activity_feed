require 'active_record'

module ActivityFeed
  module ActiveRecord
    class Item < ::ActiveRecord::Base
      set_table_name 'activity_feed_items'
        
      after_save :update_redis

      private

      def update_redis
        ActivityFeed.redis.zadd(ActivityFeed.feed_key(self.user_id), self.created_at.to_i, self.id)
      end
    end
  end
end