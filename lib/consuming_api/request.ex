defmodule Request do

  @moduledoc """
  Módulo para fazer requisições HTTP GET e tratar a resposta.
  """

  def get(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, body}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Erro ao fazer a requisição: #{inspect(reason)}"}
    end
  rescue
    error in HTTPoison.Error ->
      {:error, "Exceção ao fazer a requisição: #{error.message}"}
  end
end
