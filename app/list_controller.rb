class ListController < UITableViewController
  include Common

  attr_accessor :type, :data_source

  def viewDidLoad
    @client = Http.new
    @items = []
    view.registerClass(UITableViewCell, forCellReuseIdentifier: 'item_cell')

    revealController = self.revealViewController
    menu_bar_item = UIBarButtonItem.alloc.initWithTitle("三", style: UIBarButtonItemStylePlain, target: revealController, action: 'revealToggle:')
    self.navigationItem.leftBarButtonItem = menu_bar_item

    load_data
  end

  def load_data
    msg("正在加载")

    case @type
      when :sf
        url = Config::SF_URL
      when :cnbeta
        url = Config::CB_URL
      when :jianshu
        url = Config::JIANSHU_URL
      when :v2ex
        url = Config::V2EX_URL
      else
        url = ""
    end

    puts("data url:" + url)
    if @type == :sf
      @client.get_json(url, params: {}) do |json|
        p json.to_s
        if json.nil?
          App.alert('网络链接不正常')
        else
          @items = json["data"]["rows"]
          @items = @items.map { |i|
            p "-----item:  %@\n" % i.to_s

            it = Item.new(i)
            it
          }

          hide_msg
          view.reloadData
        end
      end
    elsif @type == :v2ex
    elsif @type == :cnbeta
      feed_parser = BW::RSSParser.new(url)
      # feed_parser.delegate = self
      feed_parser.parse do |item|
        p item.title
        json = {}
        json[:title] = item.title
        json[:link]  = item.link
        json[:created_date] = item.pubDate
        json[:excerpt] = item.description

        it = Item.new(json)
        @items.addObject(it)
        puts @items.count
      end
    end
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @items.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier("item_cell", forIndexPath: indexPath)
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: "item_cell") unless cell
    item = @items[indexPath.row]
    puts item.name


    cell.textLabel.text = item.name
    cell
  end


  def tableView(tableView, didSelectRowAtIndexPath:indexPath)

    types = [:sf, :jianshu, :v2ex, :cnbeta]

    type = :sf
    if indexPath.row <= 3
      type = types[indexPath.row]
    end

    tableView.deselectRowAtIndexPath(indexPath, animated:true)
    rc = ReadController.alloc.init
    rc.type = type
    item = @items[indexPath.row]
    rc.model = item

    self.navigationController.pushViewController(rc, animated:true)
  end
end

def when_parser_is_done
  puts "reload"
  puts @items
  view.reloadData
  hide_msg
end

def when_parser_initializes
  p "The parser is ready!"
end

def when_parser_parses
  p "The parser started parsing the document"
end


