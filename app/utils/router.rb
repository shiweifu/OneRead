module Router

  def register_router(r, &callback)
    print("注册Router:", r)
    HHRouter.shared.map(r, toBlock:callback)
  end

  def find_router(r, dic)
    print("查找Router:", r)
    b = HHRouter.shared.matchBlock(r)
    print("b:", b)
    c = b.call(dic)
    print("c:", c)
    c
  end

end
