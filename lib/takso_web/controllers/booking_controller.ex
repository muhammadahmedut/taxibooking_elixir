defmodule TaksoWeb.BookingController do
  use TaksoWeb, :controller
  
  alias Takso.{Repo, Sales.Taxi, Sales.Booking}
  import Ecto.Query

  def new(conn, _params) do
    changeset = Booking.changeset(%Booking{}, %{})
    render_form(conn, changeset)
  end

  def create(conn, %{"booking" => booking_params}) do
    changeset = Booking.changeset(%Booking{}, booking_params)
    
    if changeset.valid? do
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
    else
      # Validation failed - show form with errors
      render_form(conn, changeset)
    end
  end

  defp render_form(conn, changeset) do
    csrf_token = get_csrf_token()
    
    # Build error messages
    error_messages = build_error_messages(changeset)
    
    html = """
    <!DOCTYPE html>
    <html>
    <head>
      <title>New Booking</title>
    </head>
    <body>
      <h1>New Booking</h1>
      <p>Site under construction.</p>
      #{error_messages}
      <form action="/bookings" method="post">
        <input type="hidden" name="_csrf_token" value="#{csrf_token}">
        <input id="pickup_address" name="booking[pickup_address]" placeholder="Pickup address" required value="#{get_field_value(changeset, :pickup_address)}">
        <input id="dropoff_address" name="booking[dropoff_address]" placeholder="Dropoff address" required value="#{get_field_value(changeset, :dropoff_address)}">
        <button id="submit_button" type="submit">Submit</button>
      </form>
    </body>
    </html>
    """
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  defp build_error_messages(changeset) do
    if changeset.errors != [] do
      errors = Enum.map(changeset.errors, fn {field, {message, _}} ->
        "<div style='color: red; margin: 5px 0;'>#{field}: #{message}</div>"
      end)
      "<div style='background-color: #f8d7da; color: #721c24; padding: 10px; margin: 10px 0; border: 1px solid #f5c6cb; border-radius: 4px;'>#{Enum.join(errors, "")}</div>"
    else
      ""
    end
  end

  defp get_field_value(changeset, field) do
    case Ecto.Changeset.get_field(changeset, field) do
      nil -> ""
      value -> value
    end
  end
end
