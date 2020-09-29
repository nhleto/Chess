# frozen_string_literal: true

# display title heredoc
module TitleDisplay
  def title
    <<~HEREDOC
           ___           ___           ___           ___           ___     
          /\  \         /\__\         /\  \         /\  \         /\  \    
         /::\  \       /:/  /        /::\  \       /::\  \       /::\  \   
        /:/\:\  \     /:/__/        /:/\:\  \     /:/\ \  \     /:/\ \  \  
       /:/  \:\  \   /::\  \ ___   /::\~\:\  \   _\:\~\ \  \   _\:\~\ \  \ 
      /:/__/ \:\__\ /:/\:\  /\__\ /:/\:\ \:\__\ /\ \:\ \ \__\ /\ \:\ \ \__\
      \:\  \  \/__/ \/__\:\/:/  / \:\~\:\ \/__/ \:\ \:\ \/__/ \:\ \:\ \/__/
       \:\  \            \::/  /   \:\ \:\__\    \:\ \:\__\    \:\ \:\__\  
        \:\  \           /:/  /     \:\ \/__/     \:\/:/  /     \:\/:/  /  
         \:\__\         /:/  /       \:\__\        \::/  /       \::/  /   
          \/__/         \/__/         \/__/         \/__/         \/__/    
      
    HEREDOC
  end
end