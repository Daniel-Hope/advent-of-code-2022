

defmodule Aoc3a do

  def getScoreForLetter(letter) do
    codePoint = String.to_charlist(letter)
      |> hd
    if codePoint < 91 do
      codePoint - 38
    else
      codePoint - 96
    end
  end


  def findCommonLetter(split_line) do
    set_1 = MapSet.new(String.graphemes(Enum.at(split_line, 0)))
    set_2 = MapSet.new(String.graphemes(Enum.at(split_line, 1)))
    MapSet.intersection(set_1, set_2)
      |> MapSet.to_list()
      |> Enum.at(0)
  end

  def calcScoreForLine(line) do
    length = String.length(line)
    String.split_at(line, Integer.floor_div(length, 2))
      |> Tuple.to_list()
      |> findCommonLetter()
      |> getScoreForLetter()
  end


  def processLines(input_lines, total) do
    if Enum.empty?(input_lines) do
      total
    else
      [head | tail] = input_lines
      if head == "" do
        total
      else
        processLines(tail, total + calcScoreForLine(head))
      end
    end
  end


  def processInput(input_lines) do
    processLines(input_lines, 0)
  end

end



defmodule Aoc3b do

  def calcCommonChars(commonChars, newChars) do
    String.graphemes(newChars)
      |> MapSet.new()
      |> MapSet.intersection(commonChars)
  end

  def calcScoreForGroup(head1, head2, head3) do
    MapSet.new(String.graphemes("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")) # Rubbish but funny
      |> calcCommonChars(head1)
      |> calcCommonChars(head2)
      |> calcCommonChars(head3)
      |> MapSet.to_list()
      |> Enum.at(0)
      |> Aoc3a.getScoreForLetter()
  end

  def processLines(input_lines, total) do
    if Enum.count(input_lines) < 3 do
      total
    else
      [head1 | tail1] = input_lines
      [head2 | tail2] = tail1
      [head3 | tail3] = tail2
      processLines(tail3, total + calcScoreForGroup(head1, head2, head3))
    end
  end

  def processInput(input_lines) do
    processLines(input_lines, 0)
  end

end

IO.read(:stdio, :all)
  |> String.split("\n")
  #|> Aoc3a.processInput()
  |> Aoc3b.processInput()
  |> IO.inspect()
