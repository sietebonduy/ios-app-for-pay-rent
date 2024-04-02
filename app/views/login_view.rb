class LoginView < UIView
  attr_accessor :email_field, :password_field, :submit_button, :show_password_button

  def init
    super

    # self.backgroundColor = UIColor.whiteColor

    background_image_view = UIImageView.alloc.initWithFrame(self.bounds)
    background_image_view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
    background_image_view.image = UIImage.imageNamed("assets/login_background.jpg")
    self.addSubview(background_image_view)

    setup_email_field
    setup_password_field
    setup_show_password_button
    setup_submit_button

    self
  end

  private

  def setup_email_field
    email_label = UILabel.new
    email_label.text = 'Эл. почта:'
    email_label.textColor = UIColor.blackColor
    email_label.frame = [[20, 150], [100, 30]]
    self.addSubview(email_label)

    email_field_frame = [[20, 190], [330, 40]]
    @email_field = UITextField.new
    apply_text_field_style(email_field, email_field_frame)
    email_field.placeholder = 'some@example.com'
    email_field.text = 'admin1@mail.ru'
    addSubview(email_field)
  end

  def setup_password_field
    password_label = UILabel.new
    password_label.text = 'Пароль:'
    password_label.textColor = UIColor.blackColor
    password_label.frame = [[20, 230], [100, 30]]
    self.addSubview(password_label)

    password_field_frame = [[20, 260], [330, 40]]
    @password_field = UITextField.new
    apply_text_field_style(password_field, password_field_frame)
    password_field.secureTextEntry = true
    password_field.text = 'admin'
    addSubview(password_field)
  end

  def setup_show_password_button
    @show_password_button = UIButton.buttonWithType(UIButtonTypeCustom)
    show_password_button_frame = [[320, 235], [20, 20]]
    show_password_button.frame = show_password_button_frame
    show_password_button.setImage(UIImage.imageNamed("assets/show_password_icon"), forState: UIControlStateNormal)
    show_password_button.setImage(UIImage.imageNamed("assets/hide_password_icon"), forState: UIControlStateSelected)
    show_password_button.addTarget(self, action: 'toggle_password:', forControlEvents: UIControlEventTouchUpInside)
    self.addSubview(show_password_button)
  end

  def setup_submit_button
    @submit_button = UIButton.new
    submit_button.setTitle('Войти', forState: UIControlStateNormal)
    submit_button.setTitleColor(UIColor.blueColor, forState: UIControlStateNormal)
    submit_button_frame = [[20, 300], [330, 50]]
    submit_button.frame = submit_button_frame
    addSubview(submit_button)
  end

  def toggle_password(sender)
    password_field.secureTextEntry = !password_field.secureTextEntry?
    show_password_button.selected = !show_password_button.selected?
  end

  def apply_text_field_style(text_field, frame)
    text_field.frame = frame
    text_field.backgroundColor = UIColor.lightGrayColor
    text_field.layer.cornerRadius = 5
    text_field.leftView = UIView.alloc.initWithFrame([[0, 0], [5, 0]])
    text_field.leftViewMode = UITextFieldViewModeAlways
  end
end
