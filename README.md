# OuvragesBlock

## Installation

```ruby
gem 'ouvrages_block'
```

Append your `application.js` with:

```js
# app/assets/javascripts/application.js

//= require ouvrages_block
```

And import css too.

```css
# app/assets/stylesheets.scss

@import 'ouvrages_block';
```
## Usage

Generate block with:

```sh
rails generate block title_block title:string
```

```rb
# app/models/article.rb

class Article < ApplicationRecord
  has_blocks([:title_blocks])
end
```

```slim
# app/views/articles/_form.html.slim

= bootstrap_form_for @article do |f|
  = f.blocks_form
```

```slim
= render @article.blocks
```

Modify the form representation in `frontend/components/title_blocks/_block_form.html.slim`:

```slim
= block_form.text_field :title
```

Modfy the view representation in `frontend/components/title_blocks/_title_block.html.slim`:

```slim
= title_block.title
```

## Standard blocks

- standard_block_title
- standard_block_image
- standard_block_rich_text
- standard_block_medium_collection

