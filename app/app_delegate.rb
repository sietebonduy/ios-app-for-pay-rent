class AppDelegate
  def application(application, didFinishLaunchingWithOptions: launchOptions)
    navigation_сontroller = UINavigationController.alloc.initWithRootViewController(MainViewController.new)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigation_сontroller
    @window.makeKeyAndVisible
    $db = DBManager.new

    true
  end

  def applicationWillTerminate(application)
    puts "Application will terminate"
  end
end
