class PasswordResetMailer < ApplicationMailer
  def send_code
    @code = params[:code]
    mail(to: params[:email], subject: "Your password reset code")
  end
end
