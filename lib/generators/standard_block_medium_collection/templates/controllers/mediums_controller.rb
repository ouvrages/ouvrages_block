class Admin::MediumsController < Admin::BaseController

  helper :medium_collection

  def create
    files = params[:files]
    result = files.map do |file|
      item = Medium.new

      uid = Dragonfly.app.store(file)
      item.file_uid = uid

      view_context.medium_json(item, params[:field_name])
    end

    result = {files: result, status: :created}.to_json
    if !request.accepts.map(&:to_s).include?("application/json")
      # IE9 workaround
      render text: result
    else
      render json: result
    end
  end
end
