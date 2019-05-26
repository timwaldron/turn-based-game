# frozen_string_literal: true
require 'fileutils'
require 'json'
require 'yaml'
require_relative 'prettify'

class Player
  include Prettify
  SAVE_GAMES = Dir.home + '/.tbg/saves/'

  def initialize(name)
    if (!Dir.exist?(SAVE_GAMES + "#{name}/"))
      FileUtils.mkdir_p(SAVE_GAMES + "#{name}/")
    end

    if (!File.exist?(SAVE_GAMES + "#{name}/stats.txt"))
      default_stats(name)
      calc_attack_armour()
      save_game()
    else
      load_game(name)
    end
  end

  def save_game()

    #stats
    File.open(SAVE_GAMES + "#{@player[:name]}/stats.txt", "w") do |fs|
        fs.write(@player[:stats].to_yaml)
    end

    #equipment
    File.open(SAVE_GAMES + "#{@player[:name]}/equipment.txt", "w") do |fs|
      fs.write(@player[:equipment].to_yaml)
    end

    #inventory
    File.open(SAVE_GAMES + "#{@player[:name]}/inventory.txt", "w") do |fs|
      fs.write(@player[:inventory].to_yaml)
    end
  end

  def load_game(name)
    @player = {name: name}

    @player[:stats] = YAML.load_file(SAVE_GAMES + "#{name}/stats.txt")
    @player[:equipment] = YAML.load_file(SAVE_GAMES + "#{name}/equipment.txt")
    @player[:inventory] = YAML.load_file(SAVE_GAMES + "#{name}/inventory.txt")
  end

  def player_menu
    print(`clear`)
    display_stats
    puts("")
    puts("1: Equipment")
    puts("2: Inventory")
    puts("3: Exit")
    puts("")
    print("Option: ")
    user_input = gets.strip.to_i
    
    while(user_input < 1 || user_input > 3)
      print("Option: ")
      user_input = gets.strip.to_i
    end

    case user_input
    when 1
      equipment_menu
    when 2
      inventory_menu
    when 3
      return nil
    end
  end

  def equipment_menu
    in_change_slot_menu = true
    while(in_change_slot_menu)
      print(`clear`)
      print_equipment
      puts("Attack: #{get_attack} | Armour: #{get_armour}")
      puts("")
      puts("1: Head")
      puts("2: Chest")
      puts("3: Legs")
      puts("4: Weapon")
      puts("")
      puts("5: Exit")
      puts("")
      print("Option: ")
      user_input = gets().strip.to_i

      while (user_input < 1 || user_input > 5)
        print("Option: ")
        user_input = gets().strip.to_i
      end

      # 1: Head, 2: Chest, 3: Legs, 4: Weapon
      print_equipment_slot(user_input) if user_input != 5
      in_change_slot_menu = false if user_input == 5
    end
  end

  def choose_change_slot

  end

  def inventory_menu

  end

  # Getters
  # @return [Object]
  def get_name
    @player[:name]
  end
  def get_level
    @player[:stats][:level]
  end
  def get_exp
    @player[:stats][:experience]
  end
  def get_gold
    @player[:stats][:gold]
  end
  def get_armour()
    @player[:stats][:armour]
  end
  def get_attack()
    @player[:stats][:attack]
  end

  def print_equipment_slot(slot_id)
    print(`clear`)
    slots = ["head", "chest", "legs", "weapon"]
    desired_slot = slots[slot_id - 1]

    puts("-#{Prettify::capitalize(desired_slot)} Slot-")
    puts("")

    # Printing current equipment slot
    @player[:equipment].each do |slot_name, slot_hash|
      if (slot_name.to_s == desired_slot)
        puts("Name:\t#{slot_hash[:name]}")
        puts("Level:\t#{slot_hash[:level]}")
        puts("Rarity:\t#{Prettify::capitalize(slot_hash[:rarity])}")

        slot_hash[:stats].each do |stat, stat_value|
          puts("#{Prettify::capitalize(stat.to_s)}:\t#{stat_value}")
        end
      end
    end

    puts("")
    puts("Inventory items:")
    puts("")

    weapon_counter = 0
    equipable_inventory_items = []
    # Printing all inventory items of that slot type
    @player[:inventory].each do |item_name, item_stats|
      if item_name[:slot].to_s == desired_slot
        weapon_counter += 1
        equipable_inventory_items << item_name
        puts("Item Number: #{weapon_counter}")
        item_name.each do |stat_name, stat_value|
          puts("#{Prettify::capitalize(stat_name)}:\t#{Prettify::capitalize(stat_value)}") if stat_name.to_s != "stats"
        end
        puts("")
      end
    end

    if (weapon_counter == 0)
      puts("You don't have any items to equip")
      print("Press enter to return...")
      gets()
      return nil
    end

    puts("")
    print("Enter an Item Number you want to equip: ")
    item_id_equip = gets().strip.to_i

    while (item_id_equip < 1 || item_id_equip > weapon_counter)
      print("Enter an Item Number you want to equip: ")
      item_id_equip = gets().strip.to_i
    end

    give_item(@player[:equipment][desired_slot.to_sym])
    item_to_equip = equipable_inventory_items[weapon_counter - 1]
    remove_inventory_item(item_to_equip)
    equip_item(item_to_equip, item_to_equip[:slot])
    calc_attack_armour()
    
    puts("")
    puts("You equip #{item_to_equip[:name]}")
    puts("")
    print("Press enter to return...")
    save_game()
    gets()
  end

  def get_weapon_name()
    @player[:equipment][:weapon].each do |weapon_name, stats|
      return weapon_name
    end
  end

  def get_weapon_hash(slot)
  end

  def get_maxhealth
    @player[:stats][:maxhealth]
  end

  def get_level
    @player[:stats][:level]
  end

  # Setters
  def set_name(name)
    @player[:name] = name
    @player[:name]
  end

  # Inventory / Equipment Manipulation

  def equip_item(item, slot)
      @player[:equipment][slot.to_sym] = item
  end

  def remove_inventory_item(item)
    @player[:inventory].each do |element|
      if (element == item)
        item_index = @player[:inventory].index(item)
        @player[:inventory].delete_at(item_index)
      end
    end

    save_game()
  end

  def give_item(item)
    return nil if (item[:name].downcase == "none")
    @player[:inventory] << item
    save_game()
  end

  def calc_attack_armour
    @player[:stats][:attack] = 0
    @player[:stats][:armour] = 0

    @player[:equipment].each do |slot, slot_items|
      @player[:stats][:attack] += slot_items[:stats][:attack] if slot_items[:stats][:attack] != nil
      @player[:stats][:armour] += slot_items[:stats][:armour] if slot_items[:stats][:armour] != nil
    end
  end

  def print_equipment()
    @player[:equipment].each do |slot, slot_item|
        print("#{Prettify.capitalize(slot)}:\t")
        puts("#{slot_item[:name]}")

        next if (slot_item[:name].downcase == "none")

        case slot_item[:slot]
        when "weapon"
          puts("\t Attack: #{slot_item[:stats][:attack]}")
        else
          puts("\t Armour: #{slot_item[:stats][:armour]}")
        end

        puts("")
      # end
    end
  end

  def print_inventory(item_type = "all")
    @player[:inventory].each do |item_name, item_stats|
      item_name.each do |stat_name, stat_value|
        puts("#{Prettify::capitalize(stat_name)}: #{stat_value}") if item_name[:slot].to_s == item_type
      end
    end

  end

  def display_stats
    print(`clear`)
    puts("-- Stats for #{get_name} --")
    puts("Level:   #{get_level}")
    puts("Exp:     #{get_exp}")
    puts("Gold:    #{get_gold}")
    puts('')
    puts("Health:  #{get_maxhealth}")
    puts("Attack:  #{get_attack}")
    puts("Armour:  #{get_armour}")
  end

  def default_stats(player_name) # Loads if no save game is detected
    # @player_data

    @player = {
      name: player_name,
      stats: {
        level: 1,
        experience: 0,
        gold: 10,
        maxhealth: 100,
        special: 5,
        attack: 0,
        armour: 0
      },
      equipment: {
        head: {
          name: "None",
          level: 1, 
          slot: "head", 
          rarity: "common", 
          stats: {
            armour: 0,
            price: 0
          }
        },
        chest: {
          name: "None",
          level: 1, 
          slot: "chest", 
          rarity: "common", 
          stats: {
            armour: 0,
            price: 0
          }
        },
        legs: {
          name: "None",
          level: 1, 
          slot: "legs", 
          rarity: "common", 
          stats: {
            armour: 0,
            price: 0
          }
        },
        # shield: {
        #   name: "None",
        #   level: 1, 
        #   slot: "shield", 
        #   rarity: "common", 
        #   stats: {
        #     armour: 0,
        #     price: 0
        #   }
        # },
        weapon: { 
          name: "Weak Sword", 
          level: 1, 
          slot: "weapon", 
          rarity: "common", 
          stats: {
            attack: 5,
            price: 10
          }
        }
      },
      inventory: [
        {:name=>"Weak Cloth", :level=>1, :slot=>"inventory", :rarity=>"common", :stats=>{:price=>59}},
        {:name=>"Old Book", :level=>1, :slot=>"inventory", :rarity=>"common", :stats=>{:price=>44}},
        {:name=>"Feeble Staff", :level=>1, :slot=>"weapon", :rarity=>"common", :stats=>{:attack=>27, :price=>33}},
        {:name=>"Lame Bucket", :level=>1, :slot=>"head", :rarity=>"common", :stats=>{:armour=>3, :price=>56}},
        {:name=>"Aged Tunic", :level=>1, :slot=>"chest", :rarity=>"common", :stats=>{:armour=>3, :price=>54}},
        {:name=>"Feeble Chaps", :level=>1, :slot=>"legs", :rarity=>"common", :stats=>{:armour=>4, :price=>35}}
      ]
    }
  end
end
