defmodule TaksoWeb.PageController do
  use TaksoWeb, :controller

  def home(conn, _params) do
    html = """
    <!DOCTYPE html>
    <html>
    <head>
      <title>Takso - Taxi Booking</title>
    </head>
    <body>
      <h1>Welcome to Takso!</h1>
      <p>Your taxi booking system</p>
      
      #{if get_flash(conn, :info) do
        "<div style=\"background-color: #d4edda; color: #155724; padding: 10px; margin: 10px 0; border: 1px solid #c3e6cb; border-radius: 4px;\">#{get_flash(conn, :info)}</div>"
      else
        ""
      end}
    </body>
    </html>
    """
    html(conn, html)
  end
end
