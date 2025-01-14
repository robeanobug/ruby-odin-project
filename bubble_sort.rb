def bubble_sort(array)
  n = array.length
  loop do

    swapped = false
    for i in 0..(n - 2) do
      if array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
        swapped = true
      end
    end

    break unless swapped
  end
  array
end

print bubble_sort([4,3,78,2,0,2])