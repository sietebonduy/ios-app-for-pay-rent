class BillViewController < UIViewController
  def viewDidLoad
    logout_button = UIBarButtonItem.alloc.initWithTitle('Выйти', style: UIBarButtonItemStylePlain, target: self, action: 'logout_controller')
    back_to_account_button = UIBarButtonItem.alloc.initWithTitle('Назад', style:UIBarButtonItemStylePlain, target:self, action:'account_controller')
    self.navigationItem.rightBarButtonItem = logout_button
    self.navigationItem.leftBarButtonItem = back_to_account_button
  end

  def loadView
    self.view = BillView.new

    self.view.logout_button.addTarget(self, action: :logout_controller, forControlEvents: UIControlEventTouchUpInside)
    self.view.payment_button.addTarget(self, action: :payment_controller, forControlEvents: UIControlEventTouchUpInside)

  end

  private 

  def logout_controller
    $user.log_out
    main_view_controller = MainViewController.new
    navigationController.setViewControllers([main_view_controller], animated: true)
  end

  def account_controller
    account_view_controller = AccountViewController.new
    navigationController.setViewControllers([account_view_controller], animated: true)
  end

  def payment_controller
    payment_view_controller = PaymentViewController.new
    navigationController.setViewControllers([payment_view_controller], animated: true)
  end
end