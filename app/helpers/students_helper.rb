module StudentsHelper
  
  def gravatar_for(student)
    gravatar_id = Digest::MD5::hexdigest(student.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: student.email, class: "gravatar")
  end
end
