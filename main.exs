defmodule Image do

  def read(path) do
    file = File.open!(path, [:read, :binary])
    bm = IO.binread(file, :all)
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
    path = "img_2.bmp"
    file = read(path)

    header = String.slice(file,0..54)

    pixels = for <<r::8, g::8, b::8 <- String.slice(file,54..String.length(file)-1)>>, do: {r, g, b}
    makeNeg(pixels)
  end
end