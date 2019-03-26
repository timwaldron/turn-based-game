require './prettify'
require './battle'
require './stats'
require './skills'
require './shops'
require './player'

class TurnBasedGame
  include Prettify
  include Battle
  include Stats
  include Skills
  include Shops

  def initialize()
    splash_menu()
  end

  def splash_menu()
    print(`clear`)
    # Prettify::typewriter_text(0.05, "Welcome to the Turn Based Game!")

    main_menu()
  end

  def main_menu()
    @player = Player.new("Tim")

    while(true)
      print(`clear`)
      puts("What would you like to do?")
      puts("")
      puts("1. Go to battle")
      puts("2. Player Stats")
      puts("3. Skill Menu")
      puts("4. Shops")
      puts("")
      puts("5. Quit")
      puts("")
      print("Option: ")
      user_input = gets().strip.to_i

      while(user_input < 1 || user_input > 5)
        print("Option: ")
        user_input = gets().strip.to_i
      end

      case user_input
      when 1
        Battle::load_battle()
      when 2
        Stats::load_stats(@player)
      when 3
        Skills::load_skills()
      when 4
        Shops::load_shops()
      when 5
        exit!
      end
    end
  end
end

game = TurnBasedGame.new()