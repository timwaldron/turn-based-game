require_relative 'prettify'
require_relative 'battle'
require_relative 'stats'
require_relative 'skills'
require_relative 'shops'
require_relative 'player'
require_relative 'enemy'

# Main class of the game, run this file
class TurnBasedGame
  include Prettify
  include Battle
  include Stats
  include Skills
  include Shops
  include Enemy

  def initialize
    login_account
    splash_menu
  end

  def login_account
    # print("Please enter a username:")
    # user_name = gets().strip
  
    # while(user_name.include?("^a-zA-Z"))

    # user_name.delete("^a-zA-Z0-9") #=> abcABC123
  end

  # @return [Object]
  def splash_menu
    print(`clear`)
    # Prettify::typewriter_text(0.05, "Welcome to the Turn Based Game!")

    main_menu
  end

  # @return [Loads the main menu]
  def main_menu
    @player = Player.new('Ruby')

    loop do
      print(`clear`)
      puts('What would you like to do?')
      puts('')
      puts('1. Go To Battle')
      puts('2. Player Menu')
      puts('3. Skill Menu')
      puts('4. Shops')
      puts('')
      puts('5. Quit')
      puts('')
      print('Option: ')
      user_input = gets.strip.to_i

      while user_input < 1 || user_input > 5
        print('Option: ')
        user_input = gets.strip.to_i
      end

      case user_input
      when 1
        Battle.load_battle(@player)
      when 2
        @player.player_menu
      when 3
        Skills.load_skills
      when 4
        Shops.load_shops
      when 5
        exit!
      end
    end
  end
end

game = TurnBasedGame.new