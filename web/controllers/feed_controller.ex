defmodule StockTracker.FeedController do
  use StockTracker.Web, :controller

  alias StockTracker.Feed

  def index(conn, _params) do
    feeds = Repo.all(Feed)
    json(conn, %{things: "things"})
  end

  def create(conn, %{"feed" => feed_params}) do
    changeset = Feed.changeset(%Feed{}, feed_params)

    case Repo.insert(changeset) do
      {:ok, feed} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", feed_path(conn, :show, feed))
        |> render("show.json", feed: feed)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(StockTracker.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feed = Repo.get!(Feed, id)
    render(conn, "show.json", feed: feed)
  end

  def update(conn, %{"id" => id, "feed" => feed_params}) do
    feed = Repo.get!(Feed, id)
    changeset = Feed.changeset(feed, feed_params)

    case Repo.update(changeset) do
      {:ok, feed} ->
        render(conn, "show.json", feed: feed)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(StockTracker.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feed = Repo.get!(Feed, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(feed)

    send_resp(conn, :no_content, "")
  end
end
