class Array
  def my_each(&prc)
    self.length.times { |i| prc.call(self[i]) }
    return self
  end

  def my_select(&prc)
    result = []
    self.my_each { |n| result << n if prc.call(n) }
    result
  end

  def my_reject(&prc)
    result = []
    self.my_each {|n| result << n if !prc.call(n)}
    result
  end

  def my_all?(&prc)
    self.my_select { |n| prc.call n  } === self
  end

  def my_any?(&prc)
    self.my_each { |n| return true if prc.call(n) }
    false
  end

  def my_flatten
    result = []

    self.each do |num|
      if num.is_a?(Fixnum)
        result << num
      else
        result += num.my_flatten
      end
    end

    result
  end

  def my_zip(*args)
    result = []
    self.each_index do |i|
      arr = []
      arr << self[i]
      args.each do |n|
        arr << n[i]
      end
      result << arr
    end
    result
  end

  def my_rotate(n = 1)
    arr = self.dup
    if n > 0
      n.times do
        rotater = arr.shift
        arr << rotater
      end
    else
      n.abs.times do
        rotater = arr.pop
        arr.unshift(rotater)
      end
    end
    arr
  end

  def my_join(str = "")
    result = ''
    self.each do |element|
      result << element
      result << str
    end
    result
  end

  def my_reverse
    result = []
    i = self.length-1
    while i >= 0
      result << self[i]
      i-=1
    end
    result
  end

end

if __FILE__ == $PROGRAM_NAME
  p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
  p [ 1 ].my_reverse               #=> [1]
end
