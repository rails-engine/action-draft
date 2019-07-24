# Action Draft

Action Draft brings your ActiveRecord model to storage multiple draft attributes without add any columns to table.

[![Gem Version](https://badge.fury.io/rb/action-draft.svg)](https://rubygems.org/gems/action-draft) [![Build Status](https://travis-ci.org/rails-engine/action-draft.svg?branch=master)](https://travis-ci.org/rails-engine/action-draft)

## Installation

```ruby
gem "action-draft"
```

And then execute:
```bash
$ bundle
$ rails action_draft:install
```

## Usage

In your ActiveRecord model:

```rb
# app/models/message.rb
class Message < ApplicationRecord
  has_draft :title, :content
end
```

Now you have `draft_title`, `draft_content` attributes.

Then refer to this field in the form for the model:

```erb
<%# app/views/messages/_form.html.erb %>
<%= form_with(model: message) do |form| %>
  …
  <div class="field">
    <%= form.label :draft_title %>
    <%= form.textarea :draft_title %>
  </div>

  <div class="field">
    <%= form.label :draft_content %>
    <%= form.textarea :draft_content %>
  </div>
  …
<% end %>
```

Save draft attributes:

```rb
irb> message = Message.new
irb> message.draft_title = "Draft title"
irb> message.draft_title.to_s
"Draft title"
irb> message.draft_content = "Draft message content"
irb> message.draft_content.to_s
"Draft message content"
irb> message.save

ir> message.reload
irb> message.draft_title.to_s
"Draft title"
irb> message.draft_content.to_s
"Draft message content"
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
