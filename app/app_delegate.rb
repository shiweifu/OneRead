include PureLayoutMotion
include Router

class AppDelegate
  attr_accessor :revealController, :sf_c, :zhihu_c, :hn_c

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    init_router

    listController = self.sf_c
    listController.view.backgroundColor = UIColor.whiteColor
    nav = UINavigationController.alloc.initWithRootViewController(listController)

    menu_controller = MenuController.alloc.init

    @revealController = SWRevealViewController.alloc.initWithRearViewController(menu_controller,frontViewController:nav)

    @revealController.rearViewRevealWidth = 150 
    @revealController.rearViewRevealOverdraw = 0
    @revealController.frontViewShadowRadius = 3

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = @revealController
    @window.makeKeyAndVisible

    true
  end

  def init_router
    register_router("/list") do | params |
      list = ListController.alloc.init
      list.params = params
      list
    end

    register_router("/read") do | params |
      rc = ReadController.alloc.init
      rc.params = params
      rc 
    end

  end

  def hn_c
    unless @hn_c
      @hn_c = list_controller = find_router("/list?title=HackerNews&type=hn", {})
    end
    @hn_c
  end

  def sf_c
    unless @sf_c
      @sf_c = list_controller = find_router("/list", {"title"=>"", "type"=>:sf})
    end
    @sf_c
  end

  def zhihu_c
    unless @zhihu_c
      @zhihu_c = list_controller = find_router("/list", {"title" => "倁乎ㄖ蕔", "type" => :zhihu})
    end
    @zhihu_c
  end

end

class MenuController < UITableViewController
  TOP_CELL_HEIGHT = 64.0
  ITEMS = [" ", "SegmentFault", "知乎日报", "HackerNews", "待读", "历史",  "", "设置"]

  def viewDidLoad
    @dataSource = SSArrayDataSource.alloc.initWithItems(ITEMS)

    @dataSource.cellConfigureBlock = lambda do | cell, s, parentview, indexPath |
      if indexPath.row == 0
        iv = UIImageView.newAutoLayoutView
        cell.contentView.addSubview(iv)
        iv.pin_to_superview
        iv.image = "header".uiimage
      else
        cell.textLabel.text = s
      end
    end

    # @dataSource.cellCreationBlock  = lambda do | obj, pv, ip |

    #   cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: "menu_item")



    # end


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
      other_hight_sum = TOP_CELL_HEIGHT + (ITEMS.count-2) * 44.0 - 20
      result = [screen_height - other_hight_sum, 0].max
    end

    result
  end

  def tableView(tv, didSelectRowAtIndexPath: indexPath)
    sd = App.shared.delegate
    list_controller = nil
    if indexPath.row == 1
      list_controller = sd.sf_c
    elsif indexPath.row == 2
      list_controller = sd.zhihu_c
    end

    nav = UINavigationController.alloc.initWithRootViewController(list_controller)
    sd.revealController.frontViewController = nav
    self.revealViewController.revealToggle(nil)
  end
end
