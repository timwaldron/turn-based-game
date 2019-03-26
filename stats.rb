require './prettify'

module Stats
  include Prettify
  
  def self.load_stats(player_instance)
    @player = player_instance
    print_stats()
  end

  def self.print_equipment()
    @player.equipment.each do |item_slot, item_details|
      print("#{Prettify::capitalize(item_slot)}:")

      item_details.each do |item_name, item_stats|
        puts("\t#{Prettify::capitalize(item_name)}")

        if (item_name.to_s.downcase == "none")
          next
        end

        item_stats.each do |item_stat_name, item_stat_value|
          puts("\t#{Prettify::capitalize(item_stat_name)}:\t#{item_stat_value}")
        end
      end
    end
  end

  def self.print_inventory()
    @player.inventory.each_with_index do |inventory_item, index|
      print("#{index + 1}: ")

      inventory_item.each do |item_name, item_stats|
        puts("#{Prettify::capitalize(item_name)}")

        item_stats.each do |item_stat_name, item_stat_value|
          puts("\t#{Prettify::capitalize(item_stat_name)}: #{item_stat_value}")
        end
      end
    end
  end

  def self.print_stats()
    print(`clear`)
    puts("---------- Stats for #{@player.name} ----------")
    puts("Level:   #{@player.level}")
    puts("Exp:     #{@player.experience}")
    puts("")
    puts("Gold:    #{@player.gold}")
    puts("Special: #{@player.special}")
    puts("Health:  #{@player.maxhealth}")
    puts("")

    puts("Current Equipment:")
    print_equipment()

    puts("")
    puts("Attack:  #{@player.attack}")
    puts("Armour:  #{@player.armour}")
    puts("")
    puts("Inventory:")
    print_inventory()
    puts("")

    print("Press enter to return to the menu...")
    gets()
  end

end