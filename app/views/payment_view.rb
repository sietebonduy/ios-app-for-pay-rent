class PaymentView < UIView
  include View

  attr_accessor :logout_button, :back_to_account_button, :card_number, :month, :year, :code, :name, :submit_button

  def init
    super
    @logout_button = UIButton.new
    @logout_button.setTitle('Выйти', forState: UIControlStateNormal)
    addSubview(@logout_button)

    @back_to_account_button = UIButton.new
    @back_to_account_button.setTitle('Назад', forState: UIControlStateNormal)
    addSubview(@back_to_account_button)

    addSubview(background_image("account_background.avif", true))

    setup_payment_block

    self
  end

  private

  def setup_header(text, y_position)
    header_label = UILabel.new
    header_label.text = text
    header_label.textColor = UIColor.blackColor
    header_label.textAlignment = NSTextAlignmentCenter
    header_label.font = UIFont.boldSystemFontOfSize(20)
    header_label.frame = [[0, y_position], [screen_width, 30]]
    self.addSubview(header_label)
  end

  def add_label(options={})
    label = UILabel.new
    label.text = options[:text] || ''
    label.textColor = UIColor.blackColor
    label.font = UIFont.systemFontOfSize(options[:font] || 16)
    label.frame = [[options[:x_position], options[:y_position]], [options[:width], options[:height] || 30]]
    self.addSubview(label)
  end

  def apply_field_style(field, frame)
    field.frame = frame
    field.backgroundColor = UIColor.whiteColor
    field.layer.cornerRadius = 5
    field.leftView = UIView.alloc.initWithFrame([[0, 0], [5, 0]])
    field.leftViewMode = UITextFieldViewModeAlways
  end

  def add_field(options={})
    field = UITextField.new
    field_frame = [[options[:x_position], options[:y_position]], [options[:width], 40]]
    apply_field_style(field, field_frame)
    field.placeholder = options[:placeholder] || 
    field.text = options[:text] || ''
    addSubview(field)

    field
  end

  def setup_payment_block
    addSubview(header_label('Оплата', 100))

    add_label(:text => 'Номер карты', :x_position => 20, :y_position => 150, :width => View::SCREEN_WIDTH - 40)
    @card_number = add_field(:x_position => 20, :y_position => 180, :width => View::SCREEN_WIDTH - 40, :placeholder => 'XXXX - XXXX - XXXX - XXXX')

    add_label(:text => 'Срок действия', :x_position => 20, :y_position => 220, :width => 145)
    @month = add_field(:x_position => 20, :y_position => 250, :width => 60, :placeholder => 'mm')
    add_label(:text => '/', :x_position => 90, :y_position => 250, :width => 10, :height => 40, :font => 20)
    @year = add_field(:x_position => 105, :y_position => 250, :width => 60, :placeholder => 'yy')

    add_label(:text => 'CVC/CVV', :x_position => 250, :y_position => 220, :width => View::SCREEN_WIDTH - 250 - 20)
    @code = add_field(:x_position => 250, :y_position => 250, :width => View::SCREEN_WIDTH - 250 - 20, :placeholder => 'XXX')

    add_label(:text => 'Фамиля и имя владельца карты', :x_position => 20, :y_position => 290, :width => View::SCREEN_WIDTH - 40)
    @name = add_field(:x_position => 20, :y_position => 320, :width => View::SCREEN_WIDTH - 40, :placeholder => 'ИВАН ИВАНОВ')

    @submit_button = button(
      'Оплатить',
      UIColor.blackColor,
      [[20, 380], [View::SCREEN_WIDTH - 40, 40]]
    )
    @submit_button.titleLabel.font = UIFont.boldSystemFontOfSize(18)
    @submit_button.backgroundColor = UIColor.whiteColor
    @submit_button.layer.borderWidth = 2
    @submit_button.layer.borderColor = UIColor.blackColor.CGColor
    @submit_button.layer.cornerRadius = 15
    @submit_button.titleLabel.shadowOffset = CGSizeMake(3, 3)
    @submit_button.titleLabel.shadowColor = UIColor.grayColor
    @submit_button.layer.shadowOffset = CGSizeMake(0, 2)
    @submit_button.layer.shadowColor = UIColor.blackColor.CGColor
    @submit_button.layer.shadowOpacity = 0.5
    @submit_button.layer.shadowRadius = 2.0
    addSubview(@submit_button)
  end
end
