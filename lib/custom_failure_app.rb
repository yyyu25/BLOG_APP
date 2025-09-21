class CustomFailureApp < Devise::FailureApp
  def respond
    # 如果是 Turbo 请求（:turbo_stream），改为重定向而不是返回 401
    if request.format == :turbo_stream
      redirect
    else
      super
    end
  end
end