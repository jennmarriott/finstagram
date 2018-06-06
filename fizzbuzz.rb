(1...100).each do |number|
  buffer = ''
  if is_divisible_by_3
    buffer = buffer + "fizz"
  end
  if is_divisible_by_5
    buffer = buffer + "buzz"
  end
  if buffer != ""
    puts buffer
  else
    puts number
  end
end
