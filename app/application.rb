class Application

  def call(env)

    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)

      query = req.path.split("/items/").last

      if Item.all.any?{|i| i.name == query}
        resp.write Item.all.find{|i| i.name == query}.price
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end