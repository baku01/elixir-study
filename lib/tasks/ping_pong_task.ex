defmodule PingPongTask do

  @moduledoc """
  Módulo responsável por simular um sistema de comunicação Ping-Pong entre dois processos.
  """

  @doc """
  Inicializa os processos de Ping e Pong, envia a mensagem de início e inicia o handler de respostas.
  """

  def start do
    pong_pid = spawn(PingPongTask, :send_process_pong, [])
    ping_pid = spawn(PingPongTask, :send_process_ping, [pong_pid])

    send(ping_pid, :start)
    process_ping_pong_handler()
  end

  @doc """
  Função que representa o processo Pong. Recebe mensagens de ping, responde com pong e continua o loop.
  """

  def send_process_pong do
    receive do
      {:ping, ping_pid} ->
        IO.puts "Pong: enviando pong!"
        send(ping_pid, {:pong, self()})
        send_process_pong()
    end
  end

  @doc """
  Função que representa o processo Ping. Envia mensagens de ping, recebe respostas de pong e continua o loop.
  """

  def send_process_ping(pong_pid) do
    receive do
      :start ->
        IO.puts "Ping: enviando ping!"
        send(pong_pid, {:ping, self()})
        send_process_ping(pong_pid)
      {:pong, _pong_pid} ->
        IO.puts "Ping: recebendo pong!"
        send(pong_pid, {:ping, self()})
        send_process_ping(pong_pid)
    end
  end

  @doc """
  Função privada que lida com as respostas de pong. Continua recebendo respostas até que um timeout ocorra.
  """

  def process_ping_pong_handler do
    receive do
      {:pong, _pong_pid} ->
        IO.puts "Recebendo Ping-Pong!"
        process_ping_pong_handler()
    after
      5000 ->
        IO.puts "Encerrando o processo após 5 segundos sem resposta"
        :ok
    end
  end

end
