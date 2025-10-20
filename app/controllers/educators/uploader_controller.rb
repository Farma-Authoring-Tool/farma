class Educators::UploaderController < ApplicationController
  skip_forgery_protection

  def image
    blob = ActiveStorage::Blob.create_and_upload!(
      io:           params[:file],
      filename:     params[:file].original_filename,
      content_type: params[:file].content_type
    )

    render json: { location: rails_blob_url(blob, host: request.base_url) }, content_type: "text/html"
  end
end