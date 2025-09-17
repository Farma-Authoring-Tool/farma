module TestAssetHelpers
  def attach_picture(record, asset_path, filename: nil, content_type: 'image/jpeg')
    file_path = Rails.root.join('', asset_path)
    record.picture.attach(
      io: File.open(file_path),
      filename: filename || File.basename(file_path),
      content_type: content_type
    )
  end
end
