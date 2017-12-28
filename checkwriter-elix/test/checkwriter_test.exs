defmodule CheckwriterTest do
  use ExUnit.Case
  doctest Checkwriter

  test "writes the correct check amount" do
    assert Checkwriter.parse("400120.0") == "Four hundred thousand, one hundred twenty dollars and zero cents."
    assert Checkwriter.parse("400120.00") == "Four hundred thousand, one hundred twenty dollars and zero cents."
    assert Checkwriter.parse("400120") == "Four hundred thousand, one hundred twenty dollars and zero cents."


    assert Checkwriter.parse("333.88") == "Three hundred thirty three dollars and eighty eight cents."
    assert Checkwriter.parse("742388.15") == "Seven hundred forty two thousand, three hundred eighty eight dollars and fifteen cents."
    assert Checkwriter.parse("919616.12") == "Nine hundred nineteen thousand, six hundred sixteen dollars and twelve cents."
    assert Checkwriter.parse("12.11") == "Twelve dollars and eleven cents."
    assert Checkwriter.parse("2.0") == "Two dollars and zero cents."
    assert Checkwriter.parse("1000") == "One thousand dollars and zero cents."
    
  end

  test "parse out the cents" do
    assert Checkwriter.cents("00") == "zero cents."
    assert Checkwriter.cents("10") == "ten cents."
    assert Checkwriter.cents("20") == "twenty cents."
    assert Checkwriter.cents("29") == "twenty nine cents."
  end

  test "parse out hundreds" do
    assert Checkwriter.money("120", "dollars") == "one hundred twenty dollars"
    assert Checkwriter.money("30", "dollars") == "thirty dollars"
    assert Checkwriter.money("615", "dollars") == "six hundred fifteen dollars"
  end

  test "parse out thouands correctly" do  
    assert Checkwriter.parse_thousands("12345") == ["12", "345"]
  end

end
