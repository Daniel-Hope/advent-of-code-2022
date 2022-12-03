




defmodule Aoc2a do

  def calcShapeScore(shape) do
    case shape do
      "A" -> 1
      "B" -> 2
      "C" -> 3
      "X" -> 1
      "Y" -> 2
      "Z" -> 3
    end
  end

  def roundOutcome(opponent, us) do
    # 0 = tie, 1 = win, 2 = loss
    Integer.mod(calcShapeScore(us) - calcShapeScore(opponent), 3)
  end

  def calcWinScore(opponent, us) do
    case roundOutcome(opponent, us) do
      0 -> 3
      1 -> 6
      2 -> 0
    end
  end

  def calcRoundScore(input_line) do
    tokens = String.split(input_line, " ")
    opponent = Enum.fetch!(tokens, 0)
    us = Enum.fetch!(tokens, 1)
    calcShapeScore(us) + calcWinScore(opponent, us)
  end


  def calcAllRoundScores(input_lines, total) do
    if Enum.empty?(input_lines) do
      total
    else
      [head | tail] = input_lines
      if head == "" do
        total
      else
        calcAllRoundScores(tail, total + calcRoundScore(head))
      end
    end
  end

  def processInput(input_lines) do
    calcAllRoundScores(input_lines, 0)
  end

end

defmodule Aoc2b do

  def calcApponentShapeScore(shape) do
    case shape do
      "A" -> 1
      "B" -> 2
      "C" -> 3
    end
  end

  def calcOutcomeModifier(outcome) do
    case outcome do
      "X" -> -1
      "Y" -> 0
      "Z" -> 1
    end
  end

  def calcShapeScore(opponent, outcome) do
    Integer.mod(calcApponentShapeScore(opponent) + calcOutcomeModifier(outcome) - 1, 3) + 1
  end


  def calcWinScore(outcome) do
    case outcome do
      "X" -> 0
      "Y" -> 3
      "Z" -> 6
    end
  end


  def calcRoundScore(input_line) do
    tokens = String.split(input_line, " ")
    opponent = Enum.fetch!(tokens, 0)
    outcome = Enum.fetch!(tokens, 1)
    calcShapeScore(opponent, outcome) + calcWinScore(outcome)
  end


  def calcAllRoundScores(input_lines, total) do
    if Enum.empty?(input_lines) do
      total
    else
      [head | tail] = input_lines
      if head == "" do
        total
      else
        calcAllRoundScores(tail, total + calcRoundScore(head))
      end
    end
  end


  def processInput(input_lines) do
    calcAllRoundScores(input_lines, 0)
  end

end



IO.read(:stdio, :all)
  |> String.split("\n")
  #|> Aoc2a.processInput()
  |> Aoc2b.processInput()
  |> IO.inspect()
