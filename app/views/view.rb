module View

  SCREEN_WIDTH = UIScreen.mainScreen.bounds.size.width

  def header_label(text, y_position)
    header_label = UILabel.new
    header_label.text = text
    header_label.textColor = UIColor.blackColor
    header_label.textAlignment = NSTextAlignmentCenter
    header_label.font = UIFont.boldSystemFontOfSize(20)
    header_label.frame = [[0, y_position], [SCREEN_WIDTH, 30]]
    
    header_label
  end

  def label(text, y_position, font_size=16)
    label = UILabel.new
    label.text = text
    label.textColor = UIColor.blackColor
    label.font = UIFont.systemFontOfSize(font_size)
    label.frame = [[20, y_position], [SCREEN_WIDTH - 40, 30]]

    label
  end

  def button(title, color, frame)
    button = UIButton.new
    button.setTitle(title, forState: UIControlStateNormal)
    button.setTitle('...', forState: UIControlStateHighlighted)
    button.setTitleColor(color, forState: UIControlStateNormal)
    button.setTitleColor(color, forState: UIControlStateHighlighted)
    button.frame = frame

    button
  end

  def background_image(file_name, content_mode = nil)
    background_image_view = UIImageView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    background_image_view.contentMode = UIViewContentModeScaleAspectFill if content_mode
    background_image_view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
    background_image_view.image = UIImage.imageNamed("assets/#{file_name}")

    background_image_view
  end


  def card_view(initial_y_position, height)
    card = UIView.new
    card.frame = [[10, initial_y_position], [SCREEN_WIDTH - 20, height]]
    card.backgroundColor = UIColor.whiteColor
    card.layer.cornerRadius = 10
    card.layer.shadowColor = UIColor.blackColor.CGColor
    card.layer.shadowOffset = [0, 2]
    card.layer.shadowOpacity = 0.3
    card.layer.shadowRadius = 4

    card
  end

  def image_view(file_path, frame)
    image_view = UIImageView.alloc.initWithImage(UIImage.imageNamed("assets/#{file_path}"))
    image_view.frame = frame
    image_view.layer.cornerRadius = 10.0
    image_view.layer.masksToBounds = true

    image_view
  end

  def alert(text)
    alert = UIAlertView.new
    alert.title = text
    alert.addButtonWithTitle('OK')
    alert.show
  end
end
