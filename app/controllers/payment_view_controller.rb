class PaymentViewController < UIViewController
  include View

  def viewDidLoad
    logout_button = UIBarButtonItem.alloc.initWithTitle('Выйти', style:UIBarButtonItemStylePlain, target:self, action:'logout_controller')
    back_to_account_button = UIBarButtonItem.alloc.initWithTitle('Назад', style:UIBarButtonItemStylePlain, target:self, action:'account_controller')
    self.navigationItem.rightBarButtonItem = logout_button
    self.navigationItem.leftBarButtonItem = back_to_account_button
  end

  def loadView
    self.view = PaymentView.new
    view.submit_button.addTarget(self, action: 'submit_form', forControlEvents: UIControlEventTouchUpInside)
  end

  private

  def submit_form
    card_number = view.card_number.text
    month = view.month.text
    year = view.year.text
    code = view.code.text
    name = view.name.text

    validation_errors = valid?(card_number, month, year, code, name)
    validation_errors.select! {|key, value| value != nil }

    if validation_errors.empty?
      contract_id = $bill.contract_id
      $db.paid_bill(contract_id)
      $bill = nil
      account_view_controller = AccountViewController.new
      navigationController.setViewControllers([account_view_controller], animated: true)
      alert("Оплата прошла успешно!")
    else
      alert(validation_errors)
    end
  end

  def valid?(card_number, month, year, code, name)
    errors = {card_number: nil, date: nil, code: nil, name: nil}

    errors[:code_number] = 'Некорректный номер карты.' if card_number.match(/\b\d{13,16}\b/)  == nil
    errors[:date] = 'Некорректный срок действия.' if month.match(/^\b([1-9]|1[0-2])$/) == nil || year.match(/^(2[4-9]|[3-9][0-9])$/) == nil
    errors[:code] = 'Некорректный CVC/CVV код.' if code.match(/^\d{3}$/) == nil
    errors[:name] = 'Некорректное имя владельца карты.' if name.match(/^([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)/)  == nil

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

  def logout_controller
    $user.log_out
    main_view_controller = MainViewController.new
    navigationController.setViewControllers([main_view_controller], animated: true)
  end

  def account_controller
    account_view_controller = AccountViewController.new
    navigationController.setViewControllers([account_view_controller], animated: true)
  end
end
