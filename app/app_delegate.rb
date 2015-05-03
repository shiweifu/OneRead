include PureLayoutMotion

class AppDelegate
  attr_accessor :revealController

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    listController = ListController.alloc.init
    listController.title = '一读'
    listController.type  = :sf
    listController.view.backgroundColor = UIColor.whiteColor
    nav = UINavigationController.alloc.initWithRootViewController(listController)

    menu_controller = MenuController.alloc.init

    @revealController = SWRevealViewController.alloc.initWithRearViewController(menu_controller,frontViewController:nav)

    @revealController.rearViewRevealWidth = 120
    @revealController.rearViewRevealOverdraw = 0
    @revealController.frontViewShadowRadius = 0

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = @revealController
    @window.makeKeyAndVisible
    true
  end
end

class MenuController < UITableViewController
  TOP_CELL_HEIGHT = 64.0
  ITEMS = ["堆栈科技", "简鸡汤书", "道路探索者", "中国测试", "", "登录"]

  def viewDidLoad
    @dataSource = SSArrayDataSource.alloc.initWithItems(ITEMS)

    @dataSource.cellConfigureBlock = lambda do |cell, s, parentview, indexpath|
      cell.textLabel.text = s
    end
    view.dataSource = @dataSource
  end

  def viewWillAppear(animated)
    view.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    result = 44
    result = TOP_CELL_HEIGHT if indexPath.row == 0

    item = ITEMS[indexPath.row]

    if item.isEqualToString("")
      screen_height = App.frame.size.height
      other_hight_sum = TOP_CELL_HEIGHT + (ITEMS.count-2) * 44.0
      result = [screen_height - other_hight_sum, 0].max
    end

    result
  end

  def tableView(tv, didSelectRowAtIndexPath: indexPath)

    sf_proc = lambda do 
      puts "sf"
    end

    js_proc = lambda do
      puts "jianshu"
    end

    v2_proc = lambda do 
      puts "v2ex"
    end

    cb_proc = lambda do
      puts "cb"
      list_controller = ListController.alloc.init
      list_controller.title = "cnbeta"
      list_controller.type  = :cnbeta
      nav = UINavigationController.alloc.initWithRootViewController(list_controller)
      sd = App.shared.delegate
      sd.revealController.frontViewController = nav
      self.revealViewController.revealToggle(nil)
    end

    event_table = {0 => sf_proc, 1 => js_proc, 2 => v2_proc, 3 => cb_proc}

    p = event_table[indexPath.row]
    p.call if p

    puts ITEMS[indexPath.row]


  end
end
