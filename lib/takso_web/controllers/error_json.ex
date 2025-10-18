defmodule TaksoWeb.ErrorJSON do
  @moduledoc """
  This module is invoked by your endpoint in case of errors, and
  renders the error in your JSON format.

  See config/config.exs.
  """
  def error(tuple) do
    %{errors: translate_errors(tuple)}
  end

  defp translate_errors({:unprocessable_entity, changeset}) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  defp translate_errors({:not_found, _}) do
    %{detail: "Not Found"}
  end

  defp translate_errors({:internal_server_error, _}) do
    %{detail: "Internal Server Error"}
  end

  defp translate_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", fn _ -> to_string(value) end)
    end)
  end
end
