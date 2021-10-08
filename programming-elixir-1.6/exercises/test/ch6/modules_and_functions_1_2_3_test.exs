defmodule Times.Test do
  use ExUnit.Case, async: true

  describe "Times" do
    test "multiply given number and 2" do
      assert Times.double(4) === 8
    end

    test "multiply given number and 3" do
      assert Times.triple(4) === 12
    end

    test "multiply given number and 4" do
      assert Times.quardruple(4) === 16
    end
  end
end
