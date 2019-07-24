# frozen_string_literal: true

class CreateActionDraftContents < ActiveRecord::Migration[6.0]
  def change
    create_table :action_draft_contents do |t|
      t.references :record, null: false, polymorphic: true, index: false
      t.string :name
      t.text :content, limit: 16777215

      t.timestamps

      t.index [ :record_type, :record_id, :name ], name: "index_action_drafts_uniqueness", unique: true
    end
  end
end
