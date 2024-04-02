class AccountViewController < UIViewController
  def viewDidLoad
    logout_button = UIBarButtonItem.alloc.initWithTitle('Выйти', style: UIBarButtonItemStylePlain, target: self, action: 'logout_controller')
    navigationItem.rightBarButtonItem = logout_button

    view.account_view_controller = self
  end

  def loadView
    self.view = AccountView.new

    view.logout_button.addTarget(self, action: :logout_controller, forControlEvents: UIControlEventTouchUpInside)

    user_has_apt = $db.find_rented_apartments_for_user($user.id).any?
    if user_has_apt
      apt_id = $db.find_rented_apartments_for_user($user.id)[0][:id]
      $contract_id = $db.find_contract(apt_id)[0][:id]

      view.payment_button.addTarget(self, action: :payment_controller, forControlEvents: UIControlEventTouchUpInside)
      view.bill_button.addTarget(self, action: :bill_controller, forControlEvents: UIControlEventTouchUpInside)
    end
  end

  def reload_data
    account_view_controller = AccountViewController.new
    navigationController.setViewControllers([account_view_controller], animated: true)
  end

  private

  def logout_controller
    $user.log_out
    main_view_controller = MainViewController.new
    navigationController.setViewControllers([main_view_controller], animated: true)
  end

  def payment_controller
    payment_view_controller = PaymentViewController.new
    navigationController.setViewControllers([payment_view_controller], animated: true)
  end

  def bill_controller
    bill_payment_view_controller = BillViewController.new
    navigationController.setViewControllers([bill_payment_view_controller], animated: true)
  end
end
