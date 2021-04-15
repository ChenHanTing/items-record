class ContactMailer < ApplicationMailer
  def contact_email(title, content, email, source)
    @content, @email, @source = content, email, source
    mail(to: 's410187018@gm.ntpu.edu.tw', subject: title)
  end
end
