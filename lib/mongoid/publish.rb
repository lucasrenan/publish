module Mongoid
  module Publish
    extend ActiveSupport::Concern

    included do
      field :published_at, :type => Date
      field :published,    :type => Boolean, :default => false

      scope :published, -> { where(:published => true, :published_at.lte => Date.today) }

      before_save :set_published_at
    end

    include Mongoid::Publish::Callbacks

    def published?
      return true if self.published && self.published_at && self.published_at <= Date.today
      false
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

    module ClassMethods
      def list(includes_drafts=true)
        includes_drafts ? all : published
      end
    end

  end
end