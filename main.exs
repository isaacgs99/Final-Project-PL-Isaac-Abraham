defmodule Image do
  def read(path) do
    header=File.stream!(path,[],54)
    # data = read 55 -> n bytes
    IO.inspect(data)
  end
end