--判断字符所占字节数
function byteNumber(coding)
      if 127 >= coding then
        return 1
      elseif coding < 192 then
        return 0
      elseif coding < 224 then
        return 2
      elseif coding < 240 then
        return 3
      elseif coding < 248 then
        return 4
      elseif coding < 252 then
        return 5
      else
        return 6
      end
    end
--截取从n到le的字符串
function string.utf8Sub(s, n, le)
  if s ~= nil then
    if tostring(type(s)) == "string" then
      if n ==nil then
        n = 1
      else
        if tostring(type(n)) ~= "number" or n < 1 then
          n = 1
        end
      end
      if le == nil then
        le = 1
      else
        if tostring(type(le)) ~= "number" or le < 1 then
          le = 1
        end      
      end
      local index = 0
      local startIndex = 0
      local endIndex = 0
      for i = 1 , #s do
        local coding = string.byte(s,i)
        if coding >= 128 and coding < 192 then  
        else
          index = index + 1
          if index == n then
            startIndex = i
          end
          if index == le then
            endIndex = i + byteNumber(coding) - 1
          end
        
        end
      end
     return string.sub(s,startIndex,endIndex)
   end
  else
    return nil
  end
end
--获取第n个字符
function string.utf8Index(s,n)
  if s ~= nil then
    if tostring(type(s)) == "string" then
      if n ==nil then
        n = 1
      else
        if tostring(type(n)) ~= "number" or n < 1 then
          n = 1
        end
      end
      local index = 0
      local startIndex = 0
      for i = 1 , #s do
        local coding = string.byte(s,i)
        if coding >= 128 and coding < 192 then  
        else
          index = index + 1
          if index == n then
            return string.sub(s,i,i + byteNumber(coding) - 1)
          end
        end
      end
    end
  else
    return nil
  end
end
--获取字符串长度
function string.utf8Len(s)
  if s ~= nil then
    if tostring(type(s)) == "string" then
      local index = 0
      for i = 1 , #s do
        local coding = string.byte(s,i)
        if coding >= 128 and coding < 192 then  
        else
          index = index + 1   
        end
      end
      return index
    end
  else
    return nil
  end
end