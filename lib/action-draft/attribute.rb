# frozen_string_literal: true

module ActionDraft
  module Attribute
    extend ActiveSupport::Concern

    included do
      class_attribute :__action_draft_names
    end

    class_methods do
      # Provides access to a dependent ActionDraft::Content model that holds the draft attributes.
      # This dependent attribute is lazily instantiated and will be auto-saved when it's been changed. Example:
      #
      #   class Message < ActiveRecord::Base
      #     has_draft :title, :content
      #   end
      #
      #   message = Message.create!(draft_title: "This is draft title", draft_content: "<h1>Funny times!</h1>")
      #   message.draft_title # => "This is draft title"
      #   message.draft_content # => "<h1>Funny times!</h1>"
      #
      # If you wish to preload the dependent ActionDraft::Content model, you can use the named scope:
      #
      #   Message.all.with_draft_title # Avoids N+1 queries when you just want the draft fields.
      def has_draft(*names)
        __action_draft_names ||= []
        names = Array(names)
        names.each do |name|
          __action_draft_names << name

          class_eval <<-CODE, __FILE__, __LINE__ + 1
            def draft_#{name}
              self.draft_#{name}_content ||= ActionDraft::Content.new(name: "#{name}", record: self)
            end

            def draft_#{name}=(content)
              self.draft_#{name}.content = content
            end
          CODE

          has_one :"draft_#{name}_content", -> { where(name: name) }, class_name: "ActionDraft::Content", as: :record, inverse_of: :record, dependent: :destroy
        end

        scope :with_drafts, -> do
          names = __action_draft_names.map { |name| "draft_#{name}_content" }
          includes(*names)
        end

        after_save do
          names.each do |name|
            public_send("draft_#{name}").save if public_send("draft_#{name}").changed?
          end
        end
      end
    end
  end
end
