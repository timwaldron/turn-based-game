# frozen_string_literal: true

require_relative 'player'
require_relative 'enemy'
require_relative 'item_generator'

# Module to go load a battle
module Battle
  include ItemGenerator
  include Enemy

  def self.load_battle(player_instance)
    @player = player_instance
    go_to_battle
  end

  def self.go_to_battle
    @enemy = Enemy.load_stats
    @player_hp = @player.get_maxhealth
    @enemy_hp = @enemy[:stats][:maxhealth]
    @battle_won = nil

    while @battle_won == nil
      print `clear`
      puts(@player.get_name)
      puts("Level:  #{@player.get_level}")
      puts("Health: #{@player_hp}/#{@player.get_maxhealth}")
      puts("Attack: #{@player.get_attack} | Armour: #{@player.get_armour}")
      puts
      puts(@enemy[:name])
      puts("Level:  #{@enemy[:stats][:level]}")
      puts("Health: #{@enemy_hp}/#{@enemy[:stats][:maxhealth]}")
      puts("Attack: #{@enemy[:stats][:attack]} | Armour: #{@enemy[:stats][:armour]}")
      puts('')
      puts('1: Attack')
      puts('2: Potion (3/3)')
      puts('3: Special Attack')
      puts('')
      print('Option: ')
      user_input = gets.strip.to_i

      while user_input < 1 || user_input > 3
        print('Option: ')
        user_input = gets.strip.to_i
      end

      case user_input
      when 1
        player_attack
      when 2
        use_potion
      when 3
        use_special
      end

      award_loot() if @battle_won == true

      print 'Press return to continue...'
      gets
    end
  end

  def self.use_special
    # code here
  end

  def self.use_potion
    # code here
  end

  def self.player_attack
    damage = @player.get_attack + rand(0..10)# - @enemy[:stats][:armour]
    @enemy_hp -= damage
    puts("You attack the #{@enemy[:name]} for #{damage} damage, #{@enemy[:name]} is on #{@enemy_hp} health")
    calculate_win_lose
    enemy_attack if @battle_won == nil
  end

  def self.enemy_attack
    damage = (@enemy[:stats][:attack] + rand(0..10)) # - @player.get_armour
    @player_hp -= damage
    puts("The #{@enemy[:name]} attacks you back for #{damage} damage, you are on #{@player_hp} health")
    calculate_win_lose
  end

  def self.calculate_win_lose
    if @enemy_hp < 1
      puts("You have defeated #{@enemy[:name]}!")
      @battle_won = true
    elsif @player_hp < 1
      puts("You have been defeated by #{@enemy[:name]}!")
      @battle_won = false
    end
  end

  def self.gen_name
    potential_names = %w[Goblin Villager Wolf]
    potential_names.sample
  end

  def self.generate_enemy
    en_level = @player.get_level + rand(-3..3)
    en_level = 1 if en_level < 1

    # Returns this hash, doesn't need to be defined
    return Enemy.load_stats()
  end

  def scale_difference()

  end

  def self.award_loot()
    loot = ItemGenerator.generate_loot(@player)
    @player.give_item(loot)
    puts("")
    puts("You have obtained an item!")
    puts("")
    puts("Item Hash: #{loot}") # To do: tidy up
    puts("")
  end
end