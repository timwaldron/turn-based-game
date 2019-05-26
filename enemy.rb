module Enemy

  def self.load_stats()
    enemy = {
      name: "Enemy",
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

    return enemy
  end
end