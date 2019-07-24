# frozen_string_literal: true

module ActionDraft
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
