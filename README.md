# Action Draft

Action Draft brings your ActiveRecord model to storage multiple draft attributes without add columns to the business table.

[![Gem Version](https://badge.fury.io/rb/action-draft.svg)](https://rubygems.org/gems/action-draft) [![Build Status](https://travis-ci.org/rails-engine/action-draft.svg?branch=master)](https://travis-ci.org/rails-engine/action-draft)

## Features

- Save drafts without add columns to the business table.
- Work any ActiveRecord model, just add `has_draft :field_name`.
- A `apply_draft` method for assignment the draft values to actual attributes.
- Fallback to actual attribute value when draft is nil.

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

In your controller

```rb
class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    message.apply_draft if message_params[:publish]
    if message.save
      redirect_to messages_path, notice: "Message has created successfully"
    else
      render :new
    end
  end

  def update
    @message.assign_attributes(message_params)
    message.apply_draft if message_params[:publish]
    if message.save
      redirect_to messages_path, notice: "Message has updated successfully"
    else
      render :edit
    end
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).perrmit(:draft_title, :draft_content, :publish)
    end
end
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

irb> message.reload
irb> message.draft_title.to_s
"Draft title"
irb> message.draft_content.to_s
"Draft message content"
```

Apply draft content:

```rb
irb> message = Message.new
irb> message.draft_title = "Message title"
irb> message.apply_draft

irb> message.title
"Message title"
irb> message.draft_title
"Message title"
irb> message.save
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
