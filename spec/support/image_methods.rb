def attach_image(filename: "image.png",content_type: 'image/png')
  return {io: File.open(Rails.root.join("spec/fixtures/#{filename}")), filename: filename, content_type: content_type}
end

