defmodule TaksoWeb.BookingController do
  use TaksoWeb, :controller

  def new(conn, _params) do
    html = """
    <!DOCTYPE html>
    <html>
    <head>
      <title>New Booking</title>
    </head>
    <body>
      <h1>New Booking</h1>
      <p>Site under construction.</p>
      <input id="pickup_address" placeholder="Pickup address">
      <input id="dropoff_address" placeholder="Dropoff address">
      <button id="submit_button">Submit</button>
    </body>
    </html>
    """
    html(conn, html)
  end
end
