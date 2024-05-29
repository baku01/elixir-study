defmodule Response do

  @moduledoc """
  Módulo para acessar a List e filtrar a resposta da API
  """

  def show do
    {:ok, response} = Request.get("https://catfact.ninja/fact")

    case Jason.decode(response) do
      {:ok, %{"fact" => fact}} ->
        IO.puts(fact)
    end
  end
end
