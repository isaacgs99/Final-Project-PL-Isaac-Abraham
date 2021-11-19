defmodule Image do

  def read(path) do
    file = File.open!(path, [:read, :binary])
    bm = IO.binread(file, :all)
  end

  def write(list, name) do
    file= File.open!(name, [:write])
    IO.binwrite(file, list)
    File.close(file)
  end

  def makeNeg(pixels) do
    newPixels = for <<i <- pixels >> do
        255 - i
    end
  end

  def check255?(val) do
      if val > 255 do 
          255
      else
          val
  end

    
  end

  def makeSep(pixels) do
    newPixels = for {r,g,b} <- pixels do
                  resR = trunc((0.393 * r) + (0.769 * g) + (0.189 * b))
                  resG = trunc((0.349 * r) + (0.686 * g) + (0.168 * b))
                  resB = trunc((0.272 * r) + (0.534 * g) + (0.131 * b))

                  [check255?(resR),check255?(resG),check255?(resB)]
                end
    List.flatten(newPixels)
  end

  def makeBW(pixels) do
    newPixels = for {r,g,b} <- pixels do
                  res = ((0.3 * r) + ( 0.6 * g) + ( 0.1 * b));
                  res2 = trunc(res)
                  res3 = check255?(res2)
                  [res3,res3,res3]
                end
    List.flatten(newPixels)
  end

  def main() do
    path = "../../img.bmp"
    file = read(path)

    # Negative Image
    header = String.slice(file,0..54)
    rest = String.slice(file,54..String.length(file)-1)

    newNegative = makeNeg(rest)

    bin = Enum.into(newNegative,<<>>, fn bit -> <<bit :: 8>> end)

    negBits = <<header::binary, bin::binary>>
    
    write(negBits, "img_neg.bmp")

    # BW Image
    pixels = for <<r::8, g::8, b::8 <- rest>>, do: {r, g, b}

    newBw = makeBW(pixels)

    bin2 = Enum.into(newBw,<<>>, fn bit -> <<bit :: 8>> end)

    bwBits = <<header::binary, bin2::binary>>

    write(bwBits, "img_bw.bmp")

    # Sepia Image

    newSepia = makeSep(pixels)

    bin3 = Enum.into(newSepia,<<>>, fn bit -> <<bit :: 8>> end)

    sepBits = <<header::binary, bin3::binary>>

    write(sepBits, "img_sep.bmp")
  end
end
