class MainViewController < UIViewController
  def viewDidLoad
    # self.title = 'Main'
  end

  def loadView
    self.view = MainView.new

    view.login_button.addTarget(self, action: :login_controller, forControlEvents: UIControlEventTouchUpInside )
    view.signup_button.addTarget(self, action: :signup_controller, forControlEvents: UIControlEventTouchUpInside )
  end

  private

  def login_controller
    navigationController.pushViewController(LoginViewController.new, animated: true)
  end

  def signup_controller
    navigationController.pushViewController(SignupViewController.new, animated: true)
  end
end