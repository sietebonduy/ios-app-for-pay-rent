class SignupView < UIView
  attr_accessor :name_field, :email_field, :phone_number_field, :password_field, :submit_button, :show_password_button

  def init
    super

    background_image_view = UIImageView.alloc.initWithFrame(self.bounds)
    background_image_view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
    background_image_view.image = UIImage.imageNamed("assets/login_background.jpg")
    self.addSubview(background_image_view)

    setup_name_field
    setup_email_field
    setup_phone_number_field
    setup_password_field
    setup_submit_button
    setup_show_password_button

    self
  end

  private

  def setup_name_field
    name_label = UILabel.new
    name_label.text = 'Ваше имя:'
    name_label.textColor = UIColor.blackColor
    name_label.frame = [[20, 150], [100, 30]]
    self.addSubview(name_label)

    name_field_frame = [[20, 180], [330, 40]]
    @name_field = UITextField.new
    # @name_filed.text = 'ddd'
    apply_text_field_style(name_field, name_field_frame)
    name_field.placeholder = 'John'
    addSubview(name_field)
  end

  def setup_email_field
    email_label = UILabel.new
    email_label.text = 'Эл. почта:'
    email_label.textColor = UIColor.blackColor
    email_label.frame = [[20, 220], [100, 30]]
    self.addSubview(email_label)

    email_field_frame = [[20, 250], [330, 40]]
    @email_field = UITextField.new
    # @email_field.text = 'Ddd@mail.ru'
    apply_text_field_style(email_field, email_field_frame)
    email_field.placeholder = 'some@example.com'
    addSubview(email_field)
  end

  def setup_phone_number_field
    phone_number_label = UILabel.new
    phone_number_label.text = 'Номер телефона:'
    phone_number_label.textColor = UIColor.blackColor
    phone_number_label.frame = [[20, 290], [330, 30]]
    self.addSubview(phone_number_label)

    phone_number_field_frame = [[20, 320], [330, 40]]
    @phone_number_field = UITextField.new
    # @phone_number_field.text = '89297118215'
    apply_text_field_style(phone_number_field, phone_number_field_frame)
    addSubview(phone_number_field)
  end

  def setup_password_field
    password_label = UILabel.new
    password_label.text = 'Пароль:'
    password_label.textColor = UIColor.blackColor
    password_label.frame = [[20, 360], [100, 30]]
    self.addSubview(password_label)

    password_field_frame = [[20, 390], [330, 40]]
    @password_field = UITextField.new
    apply_text_field_style(password_field, password_field_frame)
    password_field.secureTextEntry = true
    # @password_field.text = 'dddd'
    addSubview(password_field)
  end

  def setup_submit_button
    @submit_button = UIButton.new
    submit_button.setTitle('Зарегистрироваться', forState: UIControlStateNormal)
    submit_button.setTitleColor(UIColor.blueColor, forState: UIControlStateNormal)
    submit_button_frame = [[20, 430], [330, 50]]
    submit_button.frame = submit_button_frame
    addSubview(submit_button)
  end

  def setup_show_password_button
    @show_password_button = UIButton.buttonWithType(UIButtonTypeCustom)
    show_password_button_frame = [[320, 365], [20, 20]]
    show_password_button.frame = show_password_button_frame
    show_password_button.setImage(UIImage.imageNamed("assets/show_password_icon"), forState: UIControlStateNormal)
    show_password_button.setImage(UIImage.imageNamed("assets/hide_password_icon"), forState: UIControlStateSelected)
    show_password_button.addTarget(self, action: 'toggle_password:', forControlEvents: UIControlEventTouchUpInside)
    self.addSubview(show_password_button)
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
