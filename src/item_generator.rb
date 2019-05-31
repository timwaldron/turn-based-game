module ItemGenerator

  def self.generate_loot(player_instance)
    @player = player_instance # Use this for generating "Item Levels"
    rarity = roll_rarity()
    prefix = roll_equipment_prefix(rarity)
    type = roll_type()
    name = roll_name(type, rarity)
    stats = roll_stats(@player.get_level(), rarity, type)

    item = {name: prefix + " " + name, level: @player.get_level(), slot: type, rarity: rarity, stats: stats}
    return item
  end

  def self.roll_rarity()
    item_rarity_roll = rand(0..100)

    case item_rarity_roll
    when 0...40
      return "common"
    when 40...70
      return "uncommon"
    when 70...90
      return "rare"
    when 90...100
      return "epic"
    when 100
      return "legendary"
    end
  end

  def self.roll_type()
    item_type_roll = rand(0..100)

    case item_type_roll
    when 0...60
      return "inventory" # Junk, sellable
    when 60...70
      return "head"
    when 70...80
      return "chest"
    when 80...90
      return "legs"
    when 90..100
      return "weapon"
    end
  end

  def self.rarity_scale(rarity)
    case rarity
    when "common"
      return 1
    when "uncommon"
      return 1.25
    when "rare"
      return 1.5
    when "epic"
      return 2
    when "legendary"
      return 3
    end
  end

  def self.roll_stats(player_level, rarity, type)
    price_formula = (5 * (player_level + 5) * rand(1.0..2.0).round(2)) * rarity_scale(rarity)

    case type
    when "inventory"
      return {price: price_formula.to_i}
    when "weapon"
      attack_formula = (5 * (player_level) * rand(1.0..2.0).round(2)) * rarity_scale(rarity)

      return {attack: attack_formula.to_i, price: price_formula.to_i}
    else # Must be either head, chest or legs (or shields maybe soon)
      armour_formula = ((5 * (player_level) * rand(1.0..2.0).round(2)) * rarity_scale(rarity) / 2)
      return {armour: armour_formula.to_i, price: price_formula.to_i}
    end
  end

  def self.roll_name(equipment_type, rarity)
    case equipment_type
    when "inventory"
      case rarity
      when "common"
        return ["Boot", "Rag", "Book", "Rope", "Chair"].sample()
      when "uncommon"
        return ["Badge", "Token", "Trinket", "Grail", "Chain"].sample()
      when "rare"
        return ["Buckler", "Medal", "Watch", "Cane", "Ring"].sample()
      when "epic"
        return ["Necklace", "Gem", "Amulet", "Bracelet", "Earrings"].sample()
      when "legendary"
        return ["Relic", "Totem", "Crystal", "Scroll", "Cape"].sample()
      end
    when "head"
      return ["Hat", "Helmet", "Coif", "Bucket", "Cap"].sample()
    when "chest"
      return ["Tunic", "Platebody", "Chainbody", "Bodyarmour", "Shirt"].sample()
    when "legs"
      return["Platelegs", "Plateskirt", "Chaps", "Trousers", "Briefs"].sample()
    # when "shield"
      # return [].sample()
    when "weapon"
      return ["Sword", "Dagger", "Mace", "Scimitar", "Polearm", "Staff", "Stick"].sample()
    end
  end

  def self.roll_equipment_prefix(rarity)
    name_builder = ""

    case rarity
    when "common"
      name_builder += ["Old", "Dusty", "Petty", "Feeble", "Tame", "Flabby", "Lame", "Aged", "Weak", "Infirm"].sample()
    when "uncommon"
      name_builder += ["Great", "Shiny", "Ample", "Strong", "Nice", "Fair", "Swell", "Notable", "Unusual", "Strange"].sample()
    when "rare"
      name_builder += ["Bizarre", "Unique", "Rare", "Special", "Fantastic", "Awesome", "Freakish", "Surprising", "Terrific", "Magical"].sample()
    when "epic"
      name_builder += ["Remarkable", "Extraordinary", "Miraculous", "Astonishing", "Spectacular", "Unbelievable", "Sensational", "Substantial", "Monstrous", "Incredible"].sample()
    when "legendary"
      name_builder += ["Unheard-Of", "Godlike", "Superhuman", "Unparalleled", "Unimaginable", "Mythical", "Phenomenal", "Unprecedented", "Prodigy", "Deathly"].sample()
    end

    return name_builder
  end
end