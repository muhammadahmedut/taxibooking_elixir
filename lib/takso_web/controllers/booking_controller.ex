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
      <form action="/bookings" method="post">
        <input id="pickup_address" name="booking[pickup_address]" placeholder="Pickup address" required>
        <input id="dropoff_address" name="booking[dropoff_address]" placeholder="Dropoff address" required>
        <button id="submit_button" type="submit">Submit</button>
      </form>
    </body>
    </html>
    """
    html(conn, html)
  end

  def create(conn, %{"booking" => booking_params}) do
    pickup_address = booking_params["pickup_address"]
    dropoff_address = booking_params["dropoff_address"]
    
    # Print the booking information (as requested)
    IO.puts("Booking request:")
    IO.puts("Pickup address: #{pickup_address}")
    IO.puts("Dropoff address: #{dropoff_address}")
    
    # Redirect to index page with confirmation message
    conn
    |> put_flash(:info, "Your taxi will arrive in #{:rand.uniform(10) + 1} minutes")
    |> redirect(to: "/")
  end
end
