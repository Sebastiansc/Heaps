require_relative "heap"
require 'byebug'
class Array
  def heap_sort!
    prc = Proc.new{ |el1, el2| el2 <=> el1 }
    self.heapify!(&prc)
    boundary = length - 1
    while boundary > 0
      self[0], self[boundary] = self[boundary], self[0]
      BinaryMinHeap.heapify_down(self, 0, boundary, &prc)
      boundary -= 1
    end
    self
  end

  def heapify!(&prc)
    boundary = 0
    while boundary < length
      BinaryMinHeap.heapify_up(self, boundary, length, &prc)
      boundary += 1
    end
  end
end
