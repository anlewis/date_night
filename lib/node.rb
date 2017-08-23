#make new file
#make new test file foe node class
require 'pry'

class Node
  attr_reader :score, :movie
  attr_accessor :left, :right, :depth_counter

  def initialize(score, movie, depth_counter)
    @score = score
    @movie = movie
    @depth_counter = depth_counter
  end

  def insert(score, movie)
    if @score < score
      insert_right(score, movie)
    elsif @score > score
      insert_left(score, movie)
    end
  end

  def insert_left(score, movie)
    if left.nil?
      @left = Node.new(score, movie, depth_counter + 1)
      return @left.depth_counter
    else
      @left.insert(score, movie)
    end
  end

  def insert_right(score, movie)
    if @right.nil?
      @right = Node.new(score, movie, depth_counter + 1)
      return @right.depth_counter
    else
      @right.insert(score, movie)
    end
  end

  def include?(score)
    if @score == score
      return true
    elsif @right.nil? && @left.nil?
      return false
    elsif @right.right.nil? || @right.score > score
      @left.include?(score)
    elsif @left.left.nil? || @left.score < score
      @right.include?(score)
    end
  end

  def depth_of(score)
    if @score == score
      return @depth_counter
    elsif @right.nil? && @left.nil?
      return nil
    elsif @right.nil? || @score >= score
      @left.depth_of(score)
    elsif @left.nil? || @score <= score
      @right.depth_of(score)
    end
  end

  def make_hash
    {@movie=>@score}
  end

  def min
    if @left.nil?
      make_hash
    else
      @left.min
    end
  end

  def max
    if @right.nil?
      make_hash
    else
      @right.min
    end
  end

  def sort_left
    binding.pry
    if @left.nil? && @right.nil?
      [make_hash]
    elsif @left.nil?
      [make_hash] + @right.sort_left
    else
      @left.sort_left
    end
  end

  def sort_right
      @right.sort_left
  end
end
