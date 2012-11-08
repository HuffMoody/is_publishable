require "is_publishable/version"

module IsPublishable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def publishable args = {}

      class_eval do
        include IsPublishable::InstanceMethods
      end

      instance_eval do

        # create before_save hook
        before_save do
          if published and published_at.nil?
            # when not set, set time to now (minus 1 second for easy test integration)
            self.published_at = Time.zone.now - 1.second
          elsif published.nil?
            self.published = false
          end
        end

        # create scopes
        scope :published, lambda { where(:published => true).where("published_at < ?", Time.zone.now) }
        scope :unpublished, lambda { where("published = ? OR published_at > ?", false, Time.zone.now) }

      end
    end

  end

  module InstanceMethods

    def publish!
      self.published = true
      save
    end

    def unpublish!
      self.published = false
      save
    end

    def published?(time = Time.zone.now)
      published and published_at.present? and published_at < time
    end

    def unpublished?
      !published or (published_at and published_at > Time.zone.now)
    end

  end
end

class ActiveRecord::Base
  include IsPublishable
end
