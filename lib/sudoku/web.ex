defmodule Sudoku.Web do
  use Plug.Router

  plug :match
  plug :dispatch

  def init(options) do
    # initialize options
    options
  end

  def start_server do
    Plug.Adapters.Cowboy.http(__MODULE__, nil, port: Application.get_env(:sudoku, :port))
  end

  post "/sudokus" do
    conn
    |> Plug.Conn.fetch_query_params
    |> sudokus
    |> respond
  end

  defp sudokus(conn) do
    input_str = conn.params["input"]
    resp = case Sudoku.Main.run(input_str) do
      {:ok, solution} -> Sudoku.DataStructureUtils.map_to_input_str(solution)
      _ -> "something wrong with: #{input_str}"
    end
    Plug.Conn.assign(conn, :response, IO.inspect resp)
  end

  defp respond(conn) do
    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, conn.assigns[:response])
  end

end
