# frozen_string_literal: true

require 'colorize'

# display title heredoc
module TitleDisplay
  def title
    <<-HEREDOC


      ________/\\\\\\\\\\\\\\\\\\__/\\\\\\____________________________________________________________         
      _____/\\\\\\////////__\\/\\\\\\\\\____________________________________________________________        
        ___/\\\\\\/___________\\/\\\\\\____________________________________________________________       
        __/\\\\\\_____________\\/\\\\\\_____________/\\\\\\\\\\\\\\\\___/\\\\\\\\\\\\\\\\\\\\__/\\\\\\\\\\\\\\\\\\\\___________      
          _\\/\\\\\\_____________\\/\\\\\\\\\\\\\\\\\\\\____/\\\\\\/////\\\\\\_\\/\\\\\\//////__\\/\\\\\\//////____________     
          _\\//\\\\\\____________\\/\\\\\\/////\\\\\\__/\\\\\\\\\\\\\\\\\\\\\\__\\/\\\\\\\\\\\\\\\\\\\\_\\/\\\\\\\\\\\\\\\\\\\\___________    
            __\\///\\\\\\__________\\/\\\\\\___\\/\\\\\\_\\//\\\\///////___\\////////\\\\\\_\\////////\\\\\\___________   
            ____\\////\\\\\\\\\\\\\\\\\\_\\/\\\\\\___\\/\\\\\\__\\//\\\\\\\\\\\\\\\\\\\\__/\\\\\\\\\\\\\\\\\\\\__/\\\\\\\\\\\\\\\\\\\\___________  
              _______\\/////////__\\///____\\///____\\//////////__\\//////////__\\//////////____________ 
    
  Programmed and developed by,
  Me

    HEREDOC
  end

  def intro_text_one
    puts "\n Welcome players, to..."
    # sleep(1)
    puts title.cyan
    # sleep(2)
    puts rules
    # sleep(1)
    set_players
  end

  def rules
    <<-HEREDOC
    This game was developed following the guidelines of the [Illustrated rules of Chess]
    link: [https://www.chessvariants.com/d.chess/chess.html]

    The game is programmed with all major chess moves in mind, including:
    En passant, Pawn promotion, Castling, as well as Check and Checkmate.
    
    The game ends when the enemy king is captured or checkmate is called.
    
    Because the rules have not changed much in the last 1,500 years, 
    please refer to the link if you are confused / have questions.

    HEREDOC
  end
end
