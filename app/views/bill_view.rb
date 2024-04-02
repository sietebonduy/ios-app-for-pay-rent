class BillView < UIView
  include View

  attr_accessor :logout_button, :payment_button

  def init
    super

    @logout_button = UIButton.new
    @logout_button.setTitle('Выйти', forState: UIControlStateNormal)
    addSubview(@logout_button)

    @back_to_account_button = UIButton.new
    @back_to_account_button.setTitle('Назад', forState: UIControlStateNormal)
    addSubview(@back_to_account_button)

    background_image_view = background_image("account_background.avif")
    addSubview(background_image_view)

    addSubview(card_view(100, 280))
    addSubview(header_label('Счет', 120))

    addSubview(label("Аренда: #{$bill.rent || 0} ₽", 170))
    addSubview(label("Электричество: #{$bill.electricity || 0} ₽", 200))
    addSubview(label("Вывоз мусора: #{$bill.garbage || 0} ₽", 230))
    addSubview(label("Холдное вододоснабжение: #{$bill.cold_water || 0} ₽", 260))
    addSubview(label("Горячее водоснабжение: #{$bill.hot_water || 0} ₽", 290))

    total = label("Итого: #{$bill.total} ₽", 330)
    total.font = UIFont.systemFontOfSize(20)
    addSubview(total)

    @payment_button = button(
      'Перейти к оплате',
      UIColor.blackColor,
      [[20, 400], [View::SCREEN_WIDTH - 40, 40]]
    )
    @payment_button.titleLabel.font = UIFont.boldSystemFontOfSize(18)
    @payment_button.backgroundColor = UIColor.whiteColor
    @payment_button.layer.borderWidth = 2
    @payment_button.layer.borderColor = UIColor.blackColor.CGColor
    @payment_button.layer.cornerRadius = 15
    @payment_button.titleLabel.shadowOffset = CGSizeMake(3, 3)
    @payment_button.titleLabel.shadowColor = UIColor.grayColor
    @payment_button.layer.shadowOffset = CGSizeMake(0, 2)
    @payment_button.layer.shadowColor = UIColor.blackColor.CGColor
    @payment_button.layer.shadowOpacity = 0.5
    @payment_button.layer.shadowRadius = 2.0
    addSubview(@payment_button)

    self
  end
end
