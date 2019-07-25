# frozen_string_literal: true

class Message < ApplicationRecord
  validates :title, presence: true

  has_draft :title, :content
end
