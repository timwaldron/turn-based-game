require './prettify'

module Stats
    include Prettify
    
    def self.load_stats(player_instance)
        @player = player_instance
        print_stats()
    end
    
    def self.print_stats()
        print(`clear`)
        puts("---------- Stats for #{@player.name} ----------")
        puts("Level:   #{@player}")
        gets()
        puts("Exp:     #{@player[:stats][:experience]}")
        puts("")
        puts("Gold:    #{@player[:stats][:gold]}")
        puts("Special: #{@player[:stats][:special]}")
        puts("")
        puts("Health:  #{@player[:stats][:maxhealth]}")
        puts("Attack:  #{@player[:stats][:attack]}")
        puts("Armour:  #{@player[:stats][:armour]}")
        puts("")
        
        puts("Current Equipment:")
        # print_equipment()
        
        puts("")
        puts("Attack:  #{@player[:stats][:attack]}")
        puts("Armour:  #{@player[:stats][:armour]}")
        puts("")
        puts("Inventory:")
        # print_inventory(
        puts("")
        
        print("Press enter to return to the menu...")
        gets()
    end
    
end