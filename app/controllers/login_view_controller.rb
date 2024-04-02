class LoginViewController < UIViewController
  def viewDidLoad
    # self.title = 'Log In'
  end

  def loadView
    self.view = LoginView.new
    view.submit_button.addTarget(self, action: 'submit_form', forControlEvents: UIControlEventTouchUpInside)
  end

  private

  def submit_form
    email = view.email_field.text
    password = view.password_field.text

    validation_errors = valid?(email, password)
    validation_errors.select! {|key, value| value != nil }

    if validation_errors.empty?
      account_view_controller = AccountViewController.new
      navigationController.setViewControllers([account_view_controller], animated: true)
    else
      alert(validation_errors)
    end

  end

  def valid?(email, password)
    errors = {email: nil, password: nil}

    errors[:email] = 'Некорректный email.' if email.match(/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/)  == nil
    errors[:password] = 'Пароль должен быть более 3 символов.' if  password.match(/^\w{4,}$/) == nil

    user = $db.find_user_by_email(email)

    if user.any?
      $user = User.new(user[0])
      if user[0][:password] != password
        errors[:incorrect_password] = 'Неверный пароль.'
      end
    else
      errors[:user_not_found] = 'Пользователь с таким email не найден.'
    end

    errors
  end

  def alert(params={})
    params = params.values.join("\n") if params.is_a?(Hash)
    @alert = UIAlertController.alertControllerWithTitle(
      'Alert',
      message: params,
      preferredStyle: UIAlertControllerStyleActionSheet
    )

    ok_action = UIAlertAction.actionWithTitle(
      'OK',
      style: UIAlertActionStyleDefault,
      handler: nil
    )

    @alert.addAction(ok_action)
    self.presentViewController(@alert, animated: true, completion: nil)
  end
end