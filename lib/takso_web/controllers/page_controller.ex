defmodule TaksoWeb.PageController do
  use TaksoWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
