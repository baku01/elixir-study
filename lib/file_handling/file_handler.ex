defmodule FileHandler do
  def read_file(file_path) do
    try do
      File.read!(file_path)
    rescue
      error in File.Error -> {:error, error.reason}
    end
  end
end
