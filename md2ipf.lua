
io.write(':userdoc.\n')
io.write(string.format(':title.%s\n', arg[1]))

local lListFlag = false
local lQuoteFlag = false
local lTable = nil
local lChapter = 0
local lRes = 0

local function Escape(s)
  s = string.gsub(s, '&', '&amp.')
  s = string.gsub(s, ':([^%s%p])', '&colon.%1')
  return s
end

local function Emphasis(s)
  s = string.gsub(s, '%*%*(.-)%*%*', ':hp2.%1:ehp2.')
  s = string.gsub(s, '%*(.-)%*', ':hp1.%1:ehp1.')
  return s
end

local function AddTableRow(s)
  if string.match(s, '^[|%s:-]+$') then
    return
  end
  local lCells = {}
  s = string.gsub(s, '^|', '')
  s = string.gsub(s, '|%s*$', '')
  for lCell in string.gmatch(s .. '|', '([^|]*)|') do
    table.insert(lCells, (string.gsub(lCell, '^%s*(.-)%s*$', '%1')))
  end
  lTable = lTable or {}
  table.insert(lTable, lCells)
end

local function FlushTable()
  if not lTable then
    return
  end
  local lWidths = {}
  for _, lRow in ipairs(lTable) do
    for j, lCell in ipairs(lRow) do
      lWidths[j] = math.max(lWidths[j] or 0, utf8.len((string.gsub(lCell, '&%w+%.', '_'))) + 2)
    end
  end
  io.write(string.format(":table cols='%s' rules=both frame=box.\n", table.concat(lWidths, ' ')))
  for k, lRow in ipairs(lTable) do
    io.write(':row.\n')
    for j = 1, #lWidths do
      local lCell = Emphasis(lRow[j] or '')
      if k == 1 then
        lCell = ':hp2.' .. lCell .. ':ehp2.'
      end
      io.write(':c.' .. lCell .. '\n')
    end
  end
  io.write(':etable.\n')
  lTable = nil
end

for i = 2, #arg do
  for s in io.lines(arg[i]) do
    s = Escape(s)

    if string.sub(s, 1, 2) == '> ' then
      if not lQuoteFlag then
        io.write(':lm margin=6.\n')
        lQuoteFlag = true
      end;
      s = ':p.:hp4.' .. string.sub(s, 3) .. ':ehp4.'
    else
      if lQuoteFlag then
        io.write(':lm margin=1.\n')
        lQuoteFlag = false
      end
    end
    
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

    if string.sub(s, 1, 1) == '|' then
      AddTableRow(s)
      goto continue
    end
    FlushTable()

    if #s > 0 then
      
      local lChar = string.sub(s, 1, 1)
      
      local lIndex = nil

      if lChar == '#' then
        local lTitle = string.gsub(string.match(s, '^#+ (.+)') or '', '%*', '')
        if string.match(s, '^# ') then
          lChapter = lChapter + 1
          lIndex = string.format(':i1 id=chap%d.%s', lChapter, lTitle)
        elseif string.match(s, '^## ') and lChapter > 0 then
          lIndex = string.format(':i2 refid=chap%d.%s', lChapter, lTitle)
        end
        local lLevel, lText = string.match(s, '^(#+) (.+)')
        if lLevel and #lLevel <= 3 then
          lRes = lRes + 1
          s = string.format(':h%d res=%d.%s', #lLevel, lRes, lText)
        end
      end
      
      if (lChar ~= ':') and (lChar ~= '#') then
        s = ':p.' .. s
      end
      
      if lChar == '!' then
        local lAlt, lSrc = string.match(s, '!%[(.-)%]%((.-)%.png%)')
        if lAlt then
          s = string.format(":artwork align=center name='md/%s.bmp'.", lSrc)
        end
      end
      
      s = Emphasis(s)

      if lIndex then
        s = s .. '\n' .. lIndex
      end
    end

    io.write(s .. '\n')
    ::continue::
  end
  FlushTable()
end

io.write(':euserdoc.\n')
