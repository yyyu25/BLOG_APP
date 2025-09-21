class PasswordResetsController < ApplicationController
  def new
  end

  def create
    email = params[:email].to_s.downcase

    unless User.exists?(email: email)
      flash[:alert] = "Email not found"
      return redirect_to reset_start_path
    end

    code = rand(100000..999999).to_s
    PasswordReset.create(email: email, code: code, sent_at: Time.current, verified: false)

    # 发送邮件
    PasswordResetMailer.with(email: email, code: code).send_code.deliver_later

    redirect_to reset_code_path(email: email)
  end

end
