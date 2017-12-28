defmodule Checkwriter do
  @moduledoc """
  Documentation for Checkwriter.
  """

  @deliminations ["", "thousand", "million", "billion", "trillion", "quadrillion"]

  def main(amount) do
    newamount = amount 
    |> String.replace(",", "")

    parse(newamount) 
    |> IO.puts
  end

  def parse(amount) do
    case String.split(amount, ".") do
      [d] -> dollars(d) <> " and zero cents." 
      [d, c] -> dollars(d) <> " and " <> cents(c)
    end
    |> String.replace("  ", " ")
    |> String.replace("  ", " ")
    |> String.capitalize
  end
  
  def dollars(d) do
    groups = parse_thousands(d)

    calculate_words(groups)
  end

  def calculate_words(groups, append_comma \\ false) do
    case groups do
      [] -> " dollars"
      [h | t] -> 
        l = length(groups)
        word = money(h, get_delimination(l))
    
        ret = if String.length(word) >= 1 do
          case append_comma do
            true -> ", "
            false -> ""
          end
        else 
          ""
        end
    
        ret <> word <> calculate_words(t, true)
    end
  end 

  def get_delimination(groups) do
    Enum.at(@deliminations, groups - 1)
  end

  def money(amount, delimination \\ "") do
    case String.split(amount, "") do
      ["0", "0", _] -> ""
      ["0", "0", "0", _] -> ""
      [o, _] -> ones(o) <> " " <> delimination
      [t, o, _] -> componded_tens(t <> o) <> " " <> delimination
      ["0", t, o, _] -> componded_tens(t <> o) <> " " <> delimination
      [h, t, o, _] -> ones(h) <> " hundred " <> componded_tens(t <> o) <> " " <> delimination
    end
  end

  def cents(amount) do
    case String.split(amount, "") do
      ["0", _] -> "zero cents."
      ["0", "0", _] -> "zero cents."
      _ -> componded_tens(amount) <> " cents."
    end
    
  end

  def componded_tens(amount) do
    case String.split(amount, "") do
      ["1", "0", _] -> "ten"
      ["1", "1", _] -> "eleven"
      ["1", "2", _] -> "twelve"
      ["1", "3", _] -> "thirteen"
      ["1", "4", _] -> "forteen"
      ["1", "5", _] -> "fifteen"
      ["1", "6", _] -> "sixteen"
      ["1", "7", _] -> "seventeen"
      ["1", "8", _] -> "eighteen"
      ["1", "9", _] -> "nineteen"
      [t, "0", _] -> tens(t)
      [t, o, _] -> tens(t) <> " " <> ones(o)
    end
  end

  def ones(o) do
    case o do
      "0" -> "zero"
      "1" -> "one"
      "2" -> "two"
      "3" -> "three"
      "4" -> "four"
      "5" -> "five"
      "6" -> "six"
      "7" -> "seven"
      "8" -> "eight"
      "9" -> "nine"
    end
  end

  def tens(t) do
    case t do
      "0" -> ""
      "2" -> "twenty"
      "3" -> "thirty"
      "4" -> "forty"
      "5" -> "fifty"
      "6" -> "sixty"
      "7" -> "seventy"
      "8" -> "eighty"
      "9" -> "ninety"
    end
  end

  def parse_thousands(t) do 
    t 
    |> String.reverse
    |> Stream.unfold(&String.split_at(&1, 3)) 
    |> Enum.take_while(&(&1 != ""))
    |> Enum.map(&String.reverse/1)
    |> Enum.reverse
  end
end
