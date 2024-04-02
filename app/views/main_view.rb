class MainView < UIView
  include View

  attr_accessor :login_button, :signup_button

  def init
    super

    background_image_view = background_image("bg-image-main.avif")
    self.addSubview(background_image_view)

    image_view = UIImageView.alloc.initWithImage(UIImage.imageNamed("assets/image-logo.png"))
    image_view.frame = CGRectMake(110, 260, 200, 200)
    self.addSubview(image_view)
    
    label_text = 'Войдите, чтобы посмотреть счета по арендованой квартире.'
    label = UILabel.alloc.initWithFrame(CGRectMake(20, 480, View::SCREEN_WIDTH - 40, 100))
    label.text = label_text
    label.numberOfLines = 0
    label.textAlignment = NSTextAlignmentCenter
    label.font = UIFont.systemFontOfSize(22)
    label.textColor = UIColor.whiteColor
    label.layer.shadowColor = UIColor.blackColor.CGColor
    label.layer.shadowOffset = CGSizeMake(1, 1)
    label.layer.shadowOpacity = 1.0
    label.layer.shadowRadius = 2.0
    self.addSubview(label)

    @login_button = button(
      'Вход',
      UIColor.blackColor,
      [[20, 620], [UIScreen.mainScreen.bounds.size.width - 40, 40]]
    )
    @login_button.backgroundColor = UIColor.whiteColor
    @login_button.layer.borderWidth = 2
    @login_button.layer.borderColor = UIColor.blackColor.CGColor
    @login_button.layer.cornerRadius = 15
    @login_button.titleLabel.shadowOffset = CGSizeMake(3, 3)
    @login_button.titleLabel.shadowColor = UIColor.grayColor
    @login_button.layer.shadowOffset = CGSizeMake(0, 2)
    @login_button.layer.shadowColor = UIColor.blackColor.CGColor
    @login_button.layer.shadowOpacity = 0.5
    @login_button.layer.shadowRadius = 2.0
    addSubview(@login_button)

    @signup_button = button(
      'Регистрация',
      UIColor.whiteColor,
      [[20, 680], [UIScreen.mainScreen.bounds.size.width - 40, 40]]
    )
    @signup_button.backgroundColor = UIColor.grayColor
    @signup_button.layer.borderWidth = 2
    @signup_button.layer.borderColor = UIColor.blackColor.CGColor
    @signup_button.layer.cornerRadius = 15
    @signup_button.titleLabel.shadowOffset = CGSizeMake(3, 3)
    @signup_button.titleLabel.shadowColor = UIColor.grayColor
    @signup_button.layer.shadowOffset = CGSizeMake(0, 2)
    @signup_button.layer.shadowColor = UIColor.blackColor.CGColor
    @signup_button.layer.shadowOpacity = 0.5
    @signup_button.layer.shadowRadius = 2.0
    addSubview(@signup_button)
  end
end
