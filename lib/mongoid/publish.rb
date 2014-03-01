module Mongoid
  module Publish
    extend ActiveSupport::Concern

    included do
      field :published_at, :type => Time
      field :published,    :type => Boolean, :default => false

      scope :published, -> { where(:published => true, :published_at.lte => Time.now) }
      scope :unpublished, -> { where(:published => false) }

      before_save :set_published_at
    end

    include Mongoid::Publish::Callbacks

    def published?
      return true if self.published && self.published_at && self.published_at <= Time.now
      false
    end

    def publish!
      self.published    = true
      self.save
    end

    def unpublish!
      self.published    = false
      self.save
    end

    def publication_status
      self.published? ? self.published_at : "draft"
    end

    private
    def set_published_at
      self.published_at = Time.now if self.published && self.published_at.nil?
    end

    module ClassMethods
      def list(includes_drafts=true)
        includes_drafts ? all : published
      end
    end

  end
end
