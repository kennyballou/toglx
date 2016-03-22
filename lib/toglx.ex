defmodule Toglx do
  use Application

  @config_file Application.get_env(:toglx, :config_file)

  def start(_, _) do
    Toglx.Supervisor.start_link
  end

  def submit_start_event(nil), do: {:error, :badarg}
  def submit_start_event(task) do
    submit_stop_event

    create_togglex_client
      |> Togglex.Api.TimeEntries.start(%{description: task})
  end

  def submit_stop_event do
    case current do
      %{data: nil} -> :ok
      %{data: %{id: time_entry_id}} ->
        create_togglex_client
          |> Togglex.Api.TimeEntries.stop(time_entry_id)
    end
  end

  def current do
    create_togglex_client
      |> Togglex.Api.TimeEntries.current
  end

  def list do
    create_togglex_client
      |> Togglex.Api.TimeEntries.list
  end

  defp create_togglex_client do
    Togglex.Client.new(%{access_token: get_auth_token!}, :api)
  end

  defp get_auth_token! do
    case ConfigParser.parse_file(Path.join(System.user_home!, @config_file)) do
      {:ok, parse_results} ->
        ConfigParser.get(parse_results, "toglx", "access_token")
      {:error, _} = error ->
        raise(error)
    end
  end

end
