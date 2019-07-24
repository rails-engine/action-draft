# frozen_string_literal: true

class Message < ApplicationRecord
  has_draft :title, :content
end
