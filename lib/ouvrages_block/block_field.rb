module BlockField
  def blocks_form(method = nil, options = {})
    @template.render partial: "admin/blocks/blocks_form", locals: { form: self }
  end

  def block_form(block)
    index = block.new_record? ? "__NEW__#{block.class.name.underscore.singularize.upcase}__" : nil
    @template.render partial: "admin/blocks/block_form", locals: { form: self, block: block, index: index }
  end
end
