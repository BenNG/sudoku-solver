defmodule Sudoku.Application do
  use Application

  def start(_,_) do
    Sudoku.Web.start_server
  end

end
