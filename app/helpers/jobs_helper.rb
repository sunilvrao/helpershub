module JobsHelper
  def shrink(description)
    str=description
    return str if str.length<=370
    return str[0..str[0..370].rindex(" ")-1] + " ..."
  end
end
