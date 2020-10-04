# frozen_string_literal: true

require 'yaml'
# responsible for YAML save / loads
module SaveStates
  def save_game
    yaml = YAML.dump(self)
    File.open('./savefiles/save_file.yaml', 'w+') { |x| x.write yaml }
  end

  def load_game
    save_file = File.open('./savefiles/save_file.yaml')
    game = YAML.load(save_file)
    puts "\nWelcome back!".cyan
    game.play_game
  end

  def game_states
    puts "\nIf you would like to start a new game, press 1\n\nIf you would like to load an old game, press 2"
    mode = gets.chomp.to_i until mode == 1 || mode == 2
    if Dir.empty?('savefiles')
      puts 'No saved games'
      intro_text_one
    end

    if mode == 1
      puts 'Begin new game!'
      intro_text_one
    else
      load_game
    end
  end
end
