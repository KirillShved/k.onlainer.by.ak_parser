class Test

  attr_reader :test

  def initialize
    @test = 3
  end

  def run
    mul + 4
  end

  private

  def mul
    test * 2
  end
end
