require_relative 'player'
require_relative 'item_generator'

include ItemGenerator

test_player = Player.new("Test")

common = []

100.times do
  item = ItemGenerator.generate_loot(test_player)
  p item if item[:rarity].to_s == "common"
end