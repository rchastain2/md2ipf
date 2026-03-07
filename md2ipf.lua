
io.write(':userdoc.\n')
io.write(string.format(':title.%s\n', arg[1]))

local lListFlag = false

for i = 2, #arg do
  for s in io.lines(arg[i]) do
    
    if string.sub(s, 1, 2) == '- ' then
      if not lListFlag then
        io.write('.br\n:ul compact.\n')
        lListFlag = true
      end;
      
      s = ':li.' .. string.sub(s, 3)
    
    else
      if lListFlag then
        io.write(':eul.\n.br\n')
        lListFlag = false
      end
    end
    
    if s == '' then
      s = ':p.'
    else
      if string.sub(s, 1, 1) == '#' then
        s = string.gsub(s, '### (.+)', ':h3.%1')
        s = string.gsub(s, '## (.+)', ':h2.%1')
        s = string.gsub(s, '# (.+)', ':h1.%1')
      end
      
      s = string.gsub(s, '%*%*(.-)%*%*', ':hp2.%1:ehp2.')
      s = string.gsub(s, '%*(.-)%*', ':hp1.%1:ehp1.')
    end
    
    io.write(s .. '\n')
  end
end

io.write(':euserdoc.\n')
