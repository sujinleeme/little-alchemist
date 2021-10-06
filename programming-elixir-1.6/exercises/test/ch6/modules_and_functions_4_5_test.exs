defmodule MathTest do
  use ExUnit.Case, async: true

  describe "test sum() to calculate the sum of the integers from 1 to n" do
    test "should return 15 if the integer is 5" do
      assert Math.sum(5) == 15
    end
  end

  describe "test gcd() to find the greatest common divisor between two nonnegative integers" do
    test "should return the largest number if one of them is zero" do
      assert Math.gcd(0, 4) == 4
    end

    test "should return 1 if two integers are relatively prime" do
      assert Math.gcd(3, 10) == 1
    end

    test "should return 4 if gcd of 4 and 20" do
      assert Math.gcd(4, 20) == 4
    end
  end
end
