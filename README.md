
# 📚 Repositório de Estudo Elixir

Este repositório contém vários módulos em Elixir, vou usar como um registro de estudo.

### 🏓 PingPongTask

O módulo `PingPongTask` simula um sistema de comunicação ping-pong entre dois processos.

#### Visão Geral

Este módulo inicializa dois processos, `Ping` e `Pong`, e envia uma mensagem de início para iniciar a comunicação entre eles. Os processos continuam a se comunicar até que ocorra um timeout.

#### Exemplo de Código

```elixir
def start do
  pong_pid = spawn(PingPongTask, :send_process_pong, [])
  ping_pid = spawn(PingPongTask, :send_process_ping, [pong_pid])

  send(ping_pid, :start)
  process_ping_pong_handler()
end
```

Este trecho inicializa os processos `Ping` e `Pong` e envia a mensagem de início para o processo `Ping`.

### 📂 FileHandler

O módulo `FileHandler` é responsável pela leitura de arquivos.

#### Exemplo de Código

```elixir
def read_file(file_path) do
  try do
    File.read!(file_path)
  rescue
    error in File.Error -> {:error, error.reason}
  end
end
```

Este trecho lê o conteúdo de um arquivo especificado pelo `file_path` e trata possíveis erros durante a leitura.

### 🌐 Request e Response

Os módulos `Request` e `Response` lidam com requisições HTTP e filtragem de respostas de APIs.

#### Exemplo de Código

```elixir
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
```

Este trecho realiza uma requisição HTTP GET para a URL especificada e trata possíveis erros durante a requisição.


