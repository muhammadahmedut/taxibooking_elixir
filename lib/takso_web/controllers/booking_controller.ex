defmodule TaksoWeb.BookingController do
  use TaksoWeb, :controller
  
  alias Takso.{Repo, Sales.Taxi}
  import Ecto.Query

  def new(conn, _params) do
    csrf_token = get_csrf_token()
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
        <input type="hidden" name="_csrf_token" value="#{csrf_token}">
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
    
    # Check if any taxis are available
    available_taxis = Repo.all(from t in Taxi, where: t.status == "available")
    
    # Debug: Print available taxis count
    IO.puts("Available taxis count: #{length(available_taxis)}")
    
    if Enum.empty?(available_taxis) do
      # No taxis available - show rejection message directly
      IO.puts("No taxis available - showing rejection message")
      html = """
      <!DOCTYPE html>
      <html>
      <head>
        <title>Booking Result</title>
      </head>
      <body>
        <h1>Booking Result</h1>
        <p>At present, there is no taxi available!</p>
        <a href="/bookings/new">Try again</a>
      </body>
      </html>
      """
      html(conn, html)
    else
      # Taxis available - show confirmation message
      IO.puts("Taxis available - showing confirmation message")
      conn
      |> put_flash(:info, "Your taxi will arrive in #{:rand.uniform(10) + 1} minutes")
      |> redirect(to: "/")
    end
  end
end
