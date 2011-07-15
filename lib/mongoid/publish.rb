module Mongoid
  module Publish
    extend ActiveSupport::Concern

    included do
      field :published_at, :type => Date
      field :published,    :type => Boolean, :default => false
      
      scope :published, where(:published => true, :published_at.lte => Date.today).desc(:published_at, :created_at)

      before_save :set_published_at
    end

    module InstanceMethods
      def published?
        if self.published && self.published_at && self.published_at <= Date.today
          true
        else
          false
        end
      end

      def publish!
        self.published    = true
        self.published_at = Date.today
        self.save
      end
      
      def publication_status
        self.published? ? self.published_at : "draft"
      end

      private
      def set_published_at
        self.published_at = Date.today if self.published && self.published_at.nil?
      end
    end

    module ClassMethods
    end

  end
end