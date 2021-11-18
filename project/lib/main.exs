defmodule Image do

  def read(path) do
    file = File.open!(path, [:read, :binary])
    bm = IO.binread(file, :all)
  end

  def write(list) do
    file= File.open!("img_neg.bmp", [:write])
    IO.binwrite(file, list)
    File.close(file)
  end

  def makeNeg(pixels) do
    newPixels = for tuple <- pixels do
                  newList = Tuple.to_list(tuple)
                  for val <- newList do
                    if val > 0 do
                      val - 255
                    else
                      val + 255
                    end 
                  end
    end
  end

  def main() do
    path = "../../img_2.bmp"
    file = read(path)
    write(file)
    header = String.slice(file,0..54)
    IO.inspect(header)
    rest = String.slice(file,54..String.length(file)-1)
    IO.inspect(rest)
    pixels = for <<r::8, g::8, b::8 <- String.slice(file,54..String.length(file)-1)>>, do: {r, g, b}
    newNegative = makeNeg(pixels)
    lista=List.flatten(newNegative)
    l=Enum.into(lista,<<>>, fn bit -> <<bit :: 1>> end)
    is_binary(l)

    #negBits = [header | newNegative]
    #write(negBits)
  end
end
