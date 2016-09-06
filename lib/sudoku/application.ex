defmodule Sudoku.Application do
  use Application

  def start(_,_) do
    IO.inspect "start Application"
    #
    # Plug.Adapters.Cowboy.http(__MODULE__, nil, port: Application.get_env(:sudoku, :port))

    import Supervisor.Spec

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Sudoku.Web, [], [port: Application.get_env(:sudoku, :port)])
    ]

    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def stop(_) do
    IO.inspect "stop Application"
    Sudoku.Web.stop_server
  end

end
