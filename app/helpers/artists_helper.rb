module ArtistsHelper
  def split_on_important_stuff(stuff)
    split_of_the_life_of  split_on_and  split_on_semicolon stuff
    
  end
  
  def split_of_the_life_of( names )
    new_chunks = []
    
    names.each do |name|
      if name.match("Of The Life Of") 
        crap = []
        crap << name.split("Of The Life Of").each_with_index do |chunk,i|
          new_chunks[i] = "#{chunk} Of The Life Of".strip if i == 0
          new_chunks[i] = "#{chunk}".strip unless i == 0
        end
      else
        new_chunks << name
      end
    end
    new_chunks.flatten
  end


  def split_on_semicolon( names )
    new_chunks = []
    
    names.each do |name|
      if name.match(": ") 
        crap = []
        crap << name.split(": ").each_with_index do |chunk,i|
          new_chunks[i] = "#{chunk}:".strip if i == 0
          new_chunks[i] = "#{chunk}".strip unless i == 0
        end
      else
        new_chunks << name
      end
    end
    new_chunks.flatten
  end


  def split_on_and( chunks )
    new_chunks = []
    chunks.each do | chunk |
        if chunk.match " And "
          chunk.split(" And ").each_with_index do |chunk,i|
            new_chunks[i] = "#{chunk}".strip if i == 0
            new_chunks[i] = "& #{chunk}".strip unless i == 0
          end
        else
          new_chunks << chunk
        end
    end
    new_chunks.flatten
  end

  def split_on_ampersand( chunks )
    new_chunks = []
    chunks.each do | chunk |
        if chunk.match " & "
          chunk.split(" & ").each_with_index do |chunk,i|
            new_chunks[i] = "#{chunk}".strip if i == 0
            new_chunks[i] = "& #{chunk}".strip unless i == 0
          end
        else
          new_chunks << chunk
        end
    end
    new_chunks.flatten
  end

end
