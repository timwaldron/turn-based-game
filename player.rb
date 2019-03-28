# frozen_string_literal: true
require 'fileutils'
require './prettify'

class Player
  include Prettify
  GAME_DIR = Dir.home + '/.tbg/saves/'
  SAVE_GAMES = Dir.home + '/.tbg/saves/'

  def initialize(_name)
    FileUtils.mkdir_p(SAVE_GAMES + "#{_name}/") unless Dir.exist?(SAVE_GAMES + "#{_name}/")
    default_stats(_name)
    calc_attack_armour
  end

  # Getters
  # @return [Object]
  def get_name
    @player[:name]
  end

  def get_armour()
    @player[:stats][:armour]
  end

  def get_attack()
    @player[:stats][:attack]
  end

  def get_weapon()
    @player[:equipment][:weapon].each do |weapon_name, stats|
      return weapon_name
    end
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

  def calc_attack_armour
    @player[:equipment].each do |_slot, slot_items|
      slot_items.each do |_item_name, item_name_value|
        item_name_value.each do |key, value|
          case key.to_s
          when 'attack'
            @player[:stats][:attack] += value
          when 'armour'
            @player[:stats][:armour] += value
          end
        end
      end
    end
  end

  def print_equipment
    @player[:equipment].each do |slot, slot_items|
      slot_items.each do |item_name, item_name_value|
        puts("#{Prettify.capitalize(slot)}\t#{item_name}")

        next if item_name.to_s.casecmp('none').zero?

        item_name_value.each do |stat_name, stat_value|
          puts("\t #{Prettify.capitalize(stat_name)}: #{Prettify.capitalize(stat_value)}")
        end
        puts('')
      end
    end
  end

  def print_inventory

  end

  def display_stats
    print(`clear`)
    puts("-- Stats for #{get_name} --")
    puts("Level:   #{get_level}")
    puts("Exp:     #{@player[:stats][:experience]}")
    puts('')
    puts("Gold:    #{@player[:stats][:gold]}")
    puts("Special: #{@player[:stats][:special]}")
    puts('')
    puts("Health:  #{@player[:stats][:maxhealth]}")
    puts("Attack:  #{@player[:stats][:attack]}")
    puts("Armour:  #{@player[:stats][:armour]}")
    puts('')

    puts('Current Equipment:')
    print_equipment

    puts('Inventory:')
    print_inventory
    puts('')
    print('Press enter to return to the menu...')
    gets
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
          "None": {
            armour: 0,
            attack: 0
          }
        },
        chest: {
          "None": {
            armour: 0,
            attack: 0
          }
        },
        legs: {
          "None": {
            armour: 0,
            attack: 0
          }
        },
        shield: {
          "None": {
            armour: 0,
            attack: 0
          }
        },
        weapon: {
          "Long Shlong": {
            armour: 0,
            attack: 50
          }
        }
      },
      inventory: [
        "Dusty Boot": { price: 5 },
        "Old Cloth": { price: 2 }
      ]
    }
  end
end
