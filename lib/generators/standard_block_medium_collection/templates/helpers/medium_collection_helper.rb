module MediumCollectionHelper
  def medium_json(medium, field_name)
    {
      template: render(partial: "medium_collections/medium", locals: { medium: medium, field_name: field_name }),
    }
  end
end
