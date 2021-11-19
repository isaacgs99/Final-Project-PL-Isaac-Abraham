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
    newPixels = for <<i <- pixels >> do
      if i > 0 do
        i - 255
      else
        i + 255
      end
    end
  end

  def main() do
    path = "../../snail.bmp"
    file = read(path)


    header = String.slice(file,0..54)
    rest = String.slice(file,54..String.length(file)-1)

    newNegative = makeNeg(rest)

    bin = Enum.into(newNegative,<<>>, fn bit -> <<bit :: 8>> end)

    negBits = <<header::binary, bin::binary>>
    
    write(negBits)
  end
end
