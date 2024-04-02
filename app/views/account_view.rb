class AccountView < UIScrollView
  include View

  SCREEN_HEIGHT = 1000

  attr_accessor :logout_button, :payment_button, :bill_button, :rent_buttons, :account_view_controller

  def init
    super

    content_size = CGSizeMake(View::SCREEN_WIDTH, SCREEN_HEIGHT)
    self.contentSize = content_size
    self.contentInset = UIEdgeInsetsZero

    background_image_view = background_image('account_background.avif', true)
    self.addSubview(background_image_view)

    setup_background
    setup_greeting_block
    setup_profile_info

    @apartments = $db.find_rented_apartments_for_user($user.id)
    if $db.find_rented_apartments_for_user($user.id).any?
      contract_id = 1
      bill_data = $db.get_bill(contract_id)
      $bill = Bill.new(
        {
          id: bill_data[0][:id],
          contract_id: bill_data[0][:id_contract],
          rent: bill_data[0][:rent],
          electricity: bill_data[0][:electricity],
          garbage: bill_data[0][:garbage],
          cold_water: bill_data[0][:cold_water],
          hot_water: bill_data[0][:hot_water]
        }
      )
      p $bill.inspect

      setup_bill_info
      setup_user_apartments
    else
      self.contentSize = CGSizeMake(View::SCREEN_WIDTH, SCREEN_HEIGHT + $db.find_free_apartments.size * 360)
      setup_new_rent
    end

    setup_logout_button
    self.contentOffset = CGPointZero

    self
  end

  private

  def setup_greeting_block
    apartment_image = UIImageView.alloc.initWithFrame(CGRectMake(10, 0, View::SCREEN_WIDTH - 20, 135))
    apartment_image.autoresizingMask = UIViewAutoresizingFlexibleWidth
    apartment_image.contentMode = UIViewContentModeScaleAspectFill
    apartment_image.clipsToBounds = true
    apartment_image.image = UIImage.imageNamed("assets/greeting_header.jpg")

    mask_path = UIBezierPath.bezierPathWithRoundedRect(apartment_image.bounds,
                  byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight,
                  cornerRadii: CGSizeMake(25.0, 25.0))
    mask_layer = CAShapeLayer.layer
    mask_layer.frame = apartment_image.bounds
    mask_layer.path = mask_path.CGPath
    apartment_image.layer.mask = mask_layer
  
    greeting_label = UILabel.new
    greeting_label.text = "Добро пожаловать, #{$user.name.capitalize}!"
    greeting_label.textColor = UIColor.whiteColor
    greeting_label.font = UIFont.fontWithName("Futura-Bold", size: 20)
    greeting_label.sizeToFit
    greeting_label.center = CGPointMake(apartment_image.frame.size.width / 2, apartment_image.frame.size.height / 2)
    apartment_image.addSubview(greeting_label)
  
    self.addSubview(apartment_image)
  end

  def setup_background
    self.backgroundColor = UIColor.whiteColor
  end

  def setup_menu_block
    menu_block = UIView.new
    menu_block.frame = CGRectMake(0, 0, View::SCREEN_WIDTH, 60)
    menu_block.backgroundColor = UIColor.whiteColor

    menu_block.layer.masksToBounds = false
    menu_block.layer.shadowColor = UIColor.blackColor.CGColor
    menu_block.layer.shadowOpacity = 0.4
    menu_block.layer.shadowOffset = CGSizeMake(0, 10)
    menu_block.layer.shadowRadius = 20

    rounded_corners = UIRectCornerBottomLeft | UIRectCornerBottomRight
    corner_radius = 10.0

    path = UIBezierPath.bezierPathWithRoundedRect(menu_block.bounds,
                                                  byRoundingCorners:rounded_corners,
                                                  cornerRadii:CGSizeMake(corner_radius, corner_radius))

    shape_layer = CAShapeLayer.layer
    shape_layer.path = path.CGPath
    menu_block.layer.mask = shape_layer

    self.addSubview(menu_block)
  end

  def setup_logout_button
    @logout_button = UIButton.new
    @logout_button.setTitle('Выйти', forState: UIControlStateNormal)
    addSubview(@logout_button)
  end

  def setup_profile_info
    addSubview(card_view(150, 150))

    addSubview(header_label('Личная информация', 160))
    addSubview(label("Имя: #{$user.name}", 200))
    addSubview(label("Email: #{$user.email}", 230))
    addSubview(label("Номер телефона: #{$user.phone_number || 'Не записан'}", 260))
  end

  def setup_bill_info
    addSubview(card_view(310, 150))
    addSubview(header_label('Счет за аренду', 320))
    if $bill.respond_to?(:total)
      addSubview(label("Начисленно к оплате: #{$bill.total} ₽", 370, 20))
    else
      addSubview(label("Начисленно к оплате: #{0} ₽", 370, 20))
    end

    @bill_button = button(
      'Счет',
      UIColor.blueColor,
      [[20, 420], [View::SCREEN_WIDTH / 2, 30]]
    )
    @bill_button.titleLabel.font = UIFont.boldSystemFontOfSize(18)
    @bill_button.layer.cornerRadius = 10
    @bill_button.layer.masksToBounds = true
    addSubview(@bill_button)

    @payment_button = button(
      'Оплатить',
      UIColor.blueColor,
      [[View::SCREEN_WIDTH / 2, 420], [View::SCREEN_WIDTH / 2, 30]]
    )
    @payment_button.titleLabel.font = UIFont.boldSystemFontOfSize(18)
    @payment_button.layer.cornerRadius = 10
    @payment_button.layer.masksToBounds = true
    addSubview(@payment_button)
  end

  def setup_user_apartments
    addSubview(card_view(470, @apartments.size * 135 + 60 + 190))
    addSubview(header_label('Аренда', 480))

    initial_y_position = 520
    @apartments.each_with_index  do |apartment, index|
      addSubview(image_view("apt_imgs/apt_img_#{apartment[:id] % 10}.jpg", [[20, initial_y_position], [View::SCREEN_WIDTH - 40, 180]]))
      addSubview(label("Адрес: #{apartment[:city]}, #{apartment[:street]}", initial_y_position + 190))
      addSubview(label("Площадь: #{apartment[:area]}", initial_y_position + 220))
      addSubview(label("Этаж: #{apartment[:floor]}", initial_y_position + 250))
      contract = $db.find_contract(apartment[:id])
      addSubview(label("Ежемесячная оплата: #{contract.first[:monthly_bill]} ₽", initial_y_position + 280))
      initial_y_position += 310
    end
  end

  def setup_new_rent
    list_of_apartment = $db.find_free_apartments
  
    addSubview(card_view(310, list_of_apartment.size * 370 + 50))
    addSubview(header_label('Арендовать жилье', 320))
    
    initial_y_position = 370
    @rent_buttons = []
    list_of_apartment.each_with_index do |apartment, index|
      addSubview(image_view("apt_imgs/apt_img_#{apartment[:id] % 10}.jpg", [[20, initial_y_position], [View::SCREEN_WIDTH - 40, 180]]))
      addSubview(label("Адрес: #{apartment[:city]}, #{apartment[:street]}", initial_y_position + 190))
      addSubview(label("Площадь: #{apartment[:area]}", initial_y_position + 220))
      addSubview(label("Этаж: #{apartment[:floor]}", initial_y_position + 250))
      amount = rand(15000..30000)
      addSubview(label("Ежемесячная оплата: #{amount} ₽", initial_y_position + 280))
  
      make_rent_btn = UIButton.new
      make_rent_btn.setTitle('Арендовать', forState: UIControlStateNormal)
      make_rent_btn.setTitle('...', forState: UIControlStateHighlighted)
      make_rent_btn.setTitleColor(UIColor.blueColor, forState: UIControlStateNormal)
      make_rent_btn.setTitleColor(UIColor.blueColor, forState: UIControlStateHighlighted)
      make_rent_btn.frame = [[20, initial_y_position + 315], [120, 30]]
      apartment_data = { apartment_id: apartment[:id], amount: amount }
      make_rent_btn.instance_variable_set(:@apartment_data, apartment_data)
      make_rent_btn.layer.borderWidth = 2
      make_rent_btn.layer.borderColor = UIColor.blueColor.CGColor
      make_rent_btn.layer.cornerRadius = 5
      make_rent_btn.layer.shadowOffset = CGSizeMake(0, 2)
      make_rent_btn.layer.shadowColor = UIColor.grayColor.CGColor
      make_rent_btn.layer.shadowOpacity = 0.5
      make_rent_btn.layer.shadowRadius = 3.0
      make_rent_btn.userInteractionEnabled = true
      make_rent_btn.addTarget(self, action: 'rent_button_pressed:', forControlEvents: UIControlEventTouchUpInside)
      addSubview(make_rent_btn)
      @rent_buttons << make_rent_btn

      initial_y_position += 370
    end
  end

  def rent_button_pressed(sender)
    data = sender.instance_variable_get(:@apartment_data)
    user_id = $user.id

    # p data[:apartment_id]
    # p user_id
    if $db.make_rent(user_id, data[:apartment_id], data[:amount])
      alert('Вы арендовали жилье')
      @account_view_controller.reload_data
    end
  end
end
