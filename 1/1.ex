

defmodule Aoc1a do


  def processInput(lines_array, currSum, maxSum) do
    if Enum.empty?(lines_array) do
      # Return the max sum value we found
      maxSum
    else
      [head | tail] = lines_array
      if head == "" do
        if currSum > maxSum do
          processInput(tail, 0, currSum)
        else
          processInput(tail, 0, maxSum)
        end
      else
        processInput(tail, currSum + String.to_integer(head), maxSum)
      end
    end
  end
end


defmodule Aoc1b do

  def sumElfRations(lines_array, currSum, allSums) do
    if Enum.empty?(lines_array) do
      allSums
    else
      [head | tail] = lines_array
      if head == "" do
        sumElfRations(tail, 0, [currSum | allSums])
      else
        sumElfRations(tail, currSum + String.to_integer(head), allSums)
      end
    end
  end

  def processInput(lines_array) do
    sumElfRations(lines_array, 0, [])
      |> Enum.sort(:desc)
      |> Enum.slice(0, 3)
      |> Enum.sum()
  end
end

IO.read(:stdio, :all)
  |> String.split("\n")
  #|> Aoc1a.processInput(0, -1)
  |> Aoc1b.processInput()
  |> IO.inspect()
