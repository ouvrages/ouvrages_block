module BlockField
  def blocks_form(method = nil, options = { block_left_class: "col-xs-10", block_right_class: "col-xs-2" })
    @template.render partial: "admin/blocks/blocks_form", locals: { form: self, options: options}
  end

  def block_form(block, options = {})
    template = options.delete(:template)

    if template
      index = "__NEW__#{block.class.name.underscore.singularize.upcase}__"
    else
      index = nil
    end

    @template.render partial: "admin/blocks/block_form", locals: { form: self, block: block, index: index }
  end
end
