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

In model you want use `block`:

```rb
# model.rb

has_blocks([:block])
```

In form:

```slim
= bootstrap_form_for ... do |f|
  = f.blocks_form
```

You can generate new block with:

```sh
rails generate block Name
```

## Standard blocks

- standard_block_title
- standard_block_image
- standard_block_rich_text
- standard_block_medium_collection

