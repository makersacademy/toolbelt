module StringPatches

  refine String do

    def is_positive_number?
      to_i.to_s == self && to_i > 0 
    end
  end

end
