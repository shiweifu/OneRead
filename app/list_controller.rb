class ListController < UITableViewController
  include Common
  include Router

  def viewDidLoad
    @client = Http.new
    @items = []
    view.registerClass(UITableViewCell, forCellReuseIdentifier: 'item_cell')

    setup_nav_bar_items

    load_data

    self.title = self.title_text

    @page = 1
  end

  def setup_nav_bar_items

    menu_bar_item = UIBarButtonItem.alloc.initWithImage(UIImage.imageNamed("menu"), style:UIBarButtonItemStylePlain, target:self.revealViewController, action:'revealToggle:')
    self.navigationItem.leftBarButtonItem = menu_bar_item


    bar_button_items = []

    bar_button_items.addObject(UIBarButtonItem.alloc.initWithImage(UIImage.imageNamed("refresh"), style:UIBarButtonItemStylePlain, target:self, action:'refresh:'))
    bar_button_items.addObject(UIBarButtonItem.alloc.initWithImage(UIImage.imageNamed("back"), style:UIBarButtonItemStylePlain, target:self, action:'back:'))
    bar_button_items.addObject(UIBarButtonItem.alloc.initWithImage(UIImage.imageNamed("next"), style:UIBarButtonItemStylePlain, target:self, action:'next:'))
    self.navigationItem.rightBarButtonItems = bar_button_items
  end

  def url
    case self.type
      when :sf
        url = Config::SF_URL + "?page=#{@page}"
      when :zhihu
        now = NSDate.new
        if(@page.to_i == 1)
          url = Config::ZHIHU_LATEST_URL
        else
          url = Config::ZHIHU_URL + date_to_str((@page.to_i-1).days.before(now))
        end

      else
        url = ""
    end    
    url
  end

  def load_data
    msg("正在加载")
    url = self.url
    puts("data url:" + self.url)
    if self.type == :sf
      puts("正要加载sf的数据")
      @client.get_json(self.url, params: {}) do |json|
        p json.to_s
        hide_msg
        if json.nil?
          App.alert('网络链接不正常')
        else
          items = json["data"]["rows"]
          @items = items.map { |i|
            p "-----item:  %@\n" % i.to_s

            it = Item.new(i)
            it
          }

          @data_source = SSArrayDataSource.alloc.initWithItems(@items)
          @data_source.tableView = self.tableView
          @data_source.cellClass = ItemCell
          @data_source.cellConfigureBlock = lambda { |cell, object, parent_view, index_path|
            cell.model = object
          }

          self.tableView.reloadData
        end
      end
    elsif self.type == :zhihu
      @client.get_json(self.url, params: {}) do | json|
        hide_msg
        if json.nil?
          App.alert('网络链接不正常')
        else
          items = json["stories"]
          @items = items.map { |i|
            p "-----item:  %@\n" % i.to_s
            it = Item.new({:id => i["id"], :title => i["title"], :images => i["images"]})
            it
          }

          @data_source = SSArrayDataSource.alloc.initWithItems(@items)
          @data_source.tableView = self.tableView
          @data_source.cellClass = ZhihuItemCell
          @data_source.cellConfigureBlock = lambda { |cell, object, parent_view, index_path|
            cell.model = object
          }

          @data_source.tableActionBlock = lambda {|at, pv, ip| false }
          self.tableView.reloadData
        end
      end
    end
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    type = self.type
    model = @data_source.itemAtIndexPath(indexPath)
    model_id = model.id
    rc = find_router("/read", {"title" => model.name, "type" => type, "model_id" => model_id.to_s})
    print("rc: ", rc)
    self.navigationController.pushViewController(rc, animated:true)
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    result = 44
    if self.type == :sf
      result = ItemCell.height_for_model(nil)
    elsif self.type == :zhihu
      result = ZhihuItemCell.height_for_model(nil)
    end
    result
  end

  def title_text
    self.params["title"]
  end

  def type
    self.params["type"]
  end

  def refresh(sender)
    print("refresh")
    @page = 1
    load_data
  end

  def back(sender)
    print("back")
    @page -= 1
    refresh(nil) if @page <= 0
    load_data
  end

  def next(sender)
    print("next")
    @page += 1
    load_data
  end
end
