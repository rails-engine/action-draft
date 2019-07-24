# frozen_string_literal: true

module ActionDraft
  class Engine < ::Rails::Engine
    isolate_namespace ActionDraft
    config.eager_load_namespaces << ActionDraft

    initializer "action_draft.attribute" do
      ActiveSupport.on_load(:active_record) do
        include ActionDraft::Attribute
      end
    end
  end
end
