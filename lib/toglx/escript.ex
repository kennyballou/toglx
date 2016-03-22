defmodule Toglx.Escript do
  use ArgumentParser.Builder.Escript, add_help: false
  @arg [:cmd, required: true, action: :store]
  @arg [:task, action: {:store, :+}]

  def run(%{cmd: "start", task: task}) do
    task
      |> Enum.join(" ")
      |> Toglx.submit_start_event
      |> IO.inspect
  end

  def run(%{cmd: "stop"}) do
    Toglx.submit_stop_event
      |> IO.inspect
  end

end
