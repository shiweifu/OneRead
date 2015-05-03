
class MainController < UIViewController

  SF_URL = "http://api.segmentfault.com/question/newest"

  def viewDidLoad
    view.backgroundColor = UIColor.whiteColor


    @table_view = UITableView.nw
    @table_view.registerClass(UITableViewCell, forCellReuseIdentifier:'item_cell')
    # collectionView.registerClass(Cell, forCellWithReuseIdentifier:CellIdentifier)

    view.addSubview(@table_view)
    @table_view.pin_to_sueprview_edge(:top)
    @table_view.pin_to_sueprview_edge(:leading)
    @table_view.pin_to_sueprview_edge(:trailing)
    @table_view.pin_to_sueprview_edge(:bottom)

    @table_view.dataSource = self
    @table_view.delegate   = self
    @items = []

    @client = Http.new
    @params   = {}
    @client.get_json(SF_URL, @params) do |json|
      if json.nil?
        App.alert('网络链接不正常')
      else
        @items = json["data"]["rows"]
        @items = @items.map { |i|
          p "-----item:  %@\n" % i.to_s

          it = Item.new(i)
          it
        }

        @table_view.reloadData
      end
    end

    revealController = self.revealViewController

    menu_bar_item = UIBarButtonItem.alloc.initWithTitle("三", style:UIBarButtonItemStylePlain, target:revealController, action:'revealToggle:')
    self.navigationItem.leftBarButtonItem = menu_bar_item

  end

  # def when_parser_is_done;
  #   p @feed_parser
  #   p "parse was done."
  # end


  def tableView(tableView, numberOfRowsInSection:section)
    @items.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier("item_cell", forIndexPath: indexPath)
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: "item_cell") unless cell
    item = @items[indexPath.row]
    cell.textLabel.text = item.name
    cell
  end

  def item_cell_with_index(index)
    # Item.new(@items[index])
    # item = Item.new(@items[index])

  end


end

