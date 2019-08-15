defmodule StockTracker.Router do
  use StockTracker.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", StockTracker do
    pipe_through :api
  end

  resources "/feeds", FeedController, except: [:new, :edit]
end
