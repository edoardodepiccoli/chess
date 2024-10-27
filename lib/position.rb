class Position
  attr_reader :row, :col

  # Initialize from row and column indices, or algebraic notation like "a1"
  def initialize(input)
    if input.is_a?(String)
      @row, @col = Position.parse_algebraic(input)
    elsif input.is_a?(Array) && input.size == 2
      @row, @col = input
    else
      raise ArgumentError, "Invalid position input"
    end
  end

  # Convert algebraic notation to board indices (e.g., "a1" to [7, 0])
  def self.parse_algebraic(position)
    col = position[0].ord - "a".ord
    row = 8 - position[1].to_i
    [row, col]
  end

  # Convert board indices back to algebraic notation (e.g., [7, 0] to "a1")
  def to_algebraic
    "#{(col + "a".ord).chr}#{8 - row}"
  end

  # Override equality for easier comparisons
  def ==(other)
    other.is_a?(Position) && row == other.row && col == other.col
  end

  def to_s
    to_algebraic
  end
end
