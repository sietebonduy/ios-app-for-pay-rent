class SignupViewController < UIViewController
  def viewDidLoad
    # self.title = 'Sign Up'
  end

  def loadView
    self.view = SignupView.new
    view.submit_button.addTarget(self, action: 'submit_form', forControlEvents: UIControlEventTouchUpInside)
  end

  private

  def submit_form
    name = view.name_field.text
    email = view.email_field.text
    password = view.password_field.text
    phone_number = view.phone_number_field.text

    validation_errors = valid?(name, email, password, phone_number)
    validation_errors.select! {|key, value| value != nil }

    if validation_errors.empty?
      $db.add_user(name, email, password, phone_number)
      login_view_controller = LoginViewController.new
      navigationController.setViewControllers([login_view_controller], animated: true)
    else
      alert(validation_errors)
    end
  end

  def valid?(name, email, password, phone_number)
    errors = {name: nil, email: nil, password: nil, phone_number: nil}

    errors[:name] = 'Имя должно содержать только буквы.' if name.match(/^[a-zA-z]{1,}$/) == nil
    errors[:email] = 'Некорректный email.' if email.match(/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/)  == nil
    errors[:password] = 'Пароль должен быть более 3 символов.' if  password.match(/^\w{4,}$/) == nil
    errors[:phone_number] = 'Некорректный номер телефона' if phone_number.match(/^\d{11}$/) == nil

    errors[:email_already_taken] = 'Пользователь с таким email уже есть' if $db.find_user_by_email(email).any?

    errors
  end

  def alert(params={})
    @alert = UIAlertController.alertControllerWithTitle(
      'Alert',
      message: params.values.join("\n"),
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