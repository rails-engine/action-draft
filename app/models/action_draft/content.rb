# frozen_string_literal: true

class ActionDraft::Content < ApplicationRecord
  self.table_name = "action_draft_contents"

  belongs_to :record, polymorphic: true, touch: true

  delegate :to_s, :nil?, :blank?, :present?, to: :content
end
