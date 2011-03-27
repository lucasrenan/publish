module Mongoid
  module Publish
    extend ActiveSupport::Concern
    
    included do
      field :published_at, :type => Date
      field :published,    :type => Boolean, :default => false
      
      before_save :set_published_at
    end
    
    module InstanceMethods
      private
      def set_published_at
        self.published_at = Time.now if self.published && self.published_at.nil?
      end
    end
    
    module ClassMethods
      def published(user_signed_in = false)
        result = desc(:published_at, :created_at)
        result = result.where(:published => true, :published_at.lte => Time.now) unless user_signed_in
        result
      end
    end
    
  end
end