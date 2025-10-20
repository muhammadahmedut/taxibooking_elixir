defmodule Takso.Sales.BookingTest do
  use ExUnit.Case, async: true
  alias Takso.Sales.Booking

  test "booking requires a 'pickup address'" do
    changeset = Booking.changeset(%Booking{}, %{pickup_address: nil, dropoff_address: "Liivi 2"})
    assert Keyword.has_key?(changeset.errors, :pickup_address)
  end

  test "booking requires a 'dropoff address'" do
    changeset = Booking.changeset(%Booking{}, %{pickup_address: "Liivi 2", dropoff_address: nil})
    assert Keyword.has_key?(changeset.errors, :dropoff_address)
  end

  test "booking requires both addresses" do
    changeset = Booking.changeset(%Booking{}, %{pickup_address: nil, dropoff_address: nil})
    assert Keyword.has_key?(changeset.errors, :pickup_address)
    assert Keyword.has_key?(changeset.errors, :dropoff_address)
  end

  test "booking validates that pickup and dropoff addresses are different" do
    changeset = Booking.changeset(%Booking{}, %{pickup_address: "Liivi 2", dropoff_address: "Liivi 2"})
    assert Keyword.has_key?(changeset.errors, :dropoff_address)
    assert changeset.errors[:dropoff_address] == {"must be different from pickup address", []}
  end

  test "booking is valid when addresses are different" do
    changeset = Booking.changeset(%Booking{}, %{pickup_address: "Liivi 2", dropoff_address: "Muuseumi tee 2"})
    assert changeset.valid?
    assert changeset.errors == []
  end
end
