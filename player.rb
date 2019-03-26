class Player
  attr_accessor(:name, :level, :experience, :gold, :maxhealth, :special, :attack, :armour, :inventory, :equipment)
  save_games = Dir.home + "/.o"


  def initialize(name)
    @name = name

    default_stats()

    calc_stats()
  end

  def calc_stats()
    @equipment.each do |item_slot, item_details|
      print("#{Prettify::capitalize(item_slot)}:")

      item_details.each do |item_name, item_stats|
        puts("\t#{Prettify::capitalize(item_name)}")

        if (item_name.to_s.downcase == "none")
          next
        end

        item_stats.each do |item_stat_name, item_stat_value|
          puts("TEST")
          puts("#{item_stat_name}:\t#{item_stat_value}")
          puts("TEST")

          case item_stat_name.to_s
          when "attack"
            @attack += item_stat_value
          when "armour"
            @armour += item_stat_value
          end
        end
      end
    end
  end

  def default_stats()
    # @player_data
    @level = 1
    @experience = 0
    @gold = 10

    # Battle Stats
    @maxhealth = 100
    @special = 5
    @attack = 0
    @armour = 0

    # Player carry:
    @inventory = ["Dusty Boot": {price: 5}]
    @equipment = {
      head: {
        "None": {
          armour: 0,
          attack: 0,
        }
      },
      chest: {
        "None": {
          armour: 0,
          attack: 0,
        }
      },
      legs: {
        "None": {
          armour: 0,
          attack: 0,
        }
      },
      shield: {
        "None": {
          armour: 0,
          attack: 0,
        }
      },
      weapon: {
        "Petty Sword": {
          armour: 0,
          attack: 5,
        }
      }
    }
  end

end