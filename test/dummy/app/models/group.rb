class Group < ApplicationRecord
  has_draft :name, :description
end
