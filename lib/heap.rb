require 'byebug'
class BinaryMinHeap
  def initialize(store = [], &prc)
    @store = store
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[count - 1] = @store[count - 1], @store[0]
    extracted = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count, &@prc)
    extracted
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, count - 1, count, &@prc)
  end

  protected
  attr_accessor :prc, :store

  public
  #Len is passed to implement imaginary border for heap sort
  def self.child_indices(len, parent_index)
    [parent_index * 2 + 1, parent_index * 2 + 2].select do |index|
       index < len
    end
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index.zero?
    (child_index - 1) / 2
  end

  def self.min_child_idx(arr, parent_idx, len, prc)
    indices = child_indices(arr.length, parent_idx).sort do |idx, idx1|
       prc.call(arr[idx], arr[idx1])
    end
    indices.reject!{ |i| i >= len }
    indices[0]
  end

  #Swap parent with its min child smaller than itself until none is greater
  def self.heapify_down(arr, parent_idx, len = arr.length, &prc)
    prc ||= default_prc
    swap_idx = min_child_idx(arr, parent_idx, len, prc)
    while swap_idx
      return arr unless prc.call(arr[parent_idx], arr[swap_idx]) == 1
      arr[parent_idx], arr[swap_idx] = arr[swap_idx], arr[parent_idx]
      parent_idx = swap_idx
      swap_idx = min_child_idx(arr, parent_idx, len, prc)
    end
    arr
  end

  def self.default_prc
    Proc.new{ |el, el1| el <=> el1 }
  end

  def self.heapify_up(arr, child_idx, len = arr.length, &prc)
    return if child_idx.zero?
    prc ||= default_prc
    idx = parent_index(child_idx)
    loop do
      break unless prc.call(arr[idx], arr[child_idx]) == 1
      arr[idx], arr[child_idx] = arr[child_idx], arr[idx]
      break if idx.zero?
      idx, child_idx = parent_index(idx), idx
    end
    arr
  end
end
