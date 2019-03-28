require './item_generator'

include ItemGenerator

100.times do
  p ItemGenerator.generate_loot("")
end