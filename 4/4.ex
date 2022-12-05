

defmodule Aoc4a do

  def stringToInt(assignment) do
    assignment
      |> Enum.map(&String.to_integer(&1))
  end

  def splitAssignment(assignment) do
    assignment
      |> String.split("-")
      |> stringToInt()
  end

  def splitLine(input_line) do
    input_line
      |> String.split(",")
  end


  def assignmentSubsetOfOther(left, right) do
    #IO.puts("#{left}, #{right}")
    (Enum.at(left, 0) <= Enum.at(right, 0) && Enum.at(left, 1) >= Enum.at(right, 1)) || (Enum.at(left, 0) >= Enum.at(right, 0) && Enum.at(left, 1) <= Enum.at(right, 1))
  end

  def processSplitLine(split_line) do
    left = Enum.at(split_line, 0)
    right = Enum.at(split_line, 1)
    if assignmentSubsetOfOther(left |> splitAssignment(), right |> splitAssignment()) do
      1
    else
      0
    end
  end

end


#IO.stream(:stdio, :line)
#  |> Enum.map(&String.trim(&1))
#  |> Enum.map(&Aoc4a.splitLine(&1))
#  |> Enum.map(&Aoc4a.processSplitLine(&1))
#  |> Enum.sum()
#  |> IO.inspect()


defmodule Aoc4b do

  def processAssignment(assignment) do
    #IO.puts("#{assignment}")
    procAssignemnt = Aoc4a.splitAssignment(assignment)
    #IO.puts("#{procAssignemnt}")
    createMapSetFromRange(
      Enum.at(procAssignemnt, 0),
      Enum.at(procAssignemnt, 1)
    )
  end

  # Vulnerable to a large input range
  def createMapSetFromRange(low, high) do
    #IO.puts("#{low}, #{high}")
    Range.new(low, high)
      |> MapSet.new()
  end


  def calcOverlappingNumbers(assignemnts) do
    left = Enum.at(assignemnts, 0)
    right = Enum.at(assignemnts, 1)

    MapSet.intersection(
      processAssignment(left),
      processAssignment(right)
    )
  end


  def anyOverlappingSections(overLappingMapSet) do
    if Enum.count(overLappingMapSet) > 0 do
      1
    else
      0
    end
  end

end

IO.stream(:stdio, :line)
  |> Enum.map(&String.trim(&1))
  |> Enum.map(&Aoc4a.splitLine(&1))
  |> Enum.map(&Aoc4b.calcOverlappingNumbers(&1))
  |> Enum.map(&Aoc4b.anyOverlappingSections/1)
  #|> Enum.map(&IO.inspect(&1))
  |> Enum.sum()
  |> IO.inspect()
