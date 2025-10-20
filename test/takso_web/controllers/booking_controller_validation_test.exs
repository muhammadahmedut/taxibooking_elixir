defmodule TaksoWeb.BookingControllerValidationTest do
  use TaksoWeb.ConnCase

  alias Takso.{Repo, Sales.Taxi, Sales.Booking}

  test "shows validation errors when pickup address is missing", %{conn: conn} do
    Repo.insert!(%Taxi{status: "available"})
    
    conn = post conn, "/bookings", %{booking: %{pickup_address: "", dropoff_address: "Liivi 2"}}
    
    # Should show validation errors and not redirect
    assert html_response(conn, 200) =~ ~r/pickup_address.*can't be blank/
  end

  test "shows validation errors when dropoff address is missing", %{conn: conn} do
    Repo.insert!(%Taxi{status: "available"})
    
    conn = post conn, "/bookings", %{booking: %{pickup_address: "Liivi 2", dropoff_address: ""}}
    
    # Should show validation errors and not redirect
    assert html_response(conn, 200) =~ ~r/dropoff_address.*can't be blank/
  end

  test "shows validation error when addresses are the same", %{conn: conn} do
    Repo.insert!(%Taxi{status: "available"})
    
    conn = post conn, "/bookings", %{booking: %{pickup_address: "Liivi 2", dropoff_address: "Liivi 2"}}
    
    # Should show validation errors and not redirect
    assert html_response(conn, 200) =~ ~r/must be different from pickup address/
  end

  test "processes booking when validation passes", %{conn: conn} do
    Repo.insert!(%Taxi{status: "available"})
    
    conn = post conn, "/bookings", %{booking: %{pickup_address: "Liivi 2", dropoff_address: "Muuseumi tee 2"}}
    
    # Should redirect to home page with flash message
    assert redirected_to(conn) == "/"
    conn = get conn, redirected_to(conn)
    assert html_response(conn, 200) =~ ~r/Your taxi will arrive in \d+ minutes/
  end
end
