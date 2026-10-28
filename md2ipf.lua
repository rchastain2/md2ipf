
io.write(':userdoc.\n')
io.write(string.format(':title.%s\n', arg[1]))

local INDEX_FILE = 'index.txt'

local lListFlag = false
local lQuoteFlag = false
local lTable = nil
local lRes = 0
local lTerms = {}
local lTopicTerms = {}
local lFileRes = {}
local lOListFlag = false
local lNote = nil
local lNoteNumber = 0
local lTopicTitles = {}
local lTopicChapters = {}
local lTitleCounts = {}

local function Escape(s)
  s = string.gsub(s, '&', '&amp.')
  s = string.gsub(s, ':([^%s%p])', '&colon.%1')
  return s
end

local function StripNumber(s)
  s = string.gsub(s, '^Chapitre %d+%. ', '')
  s = string.gsub(s, '^[IVXLC]+%. ', '')
  s = string.gsub(s, '^[A-Z]%. ', '')
  s = string.gsub(s, '^%d+%. ', '')
  return s
end

local CAPITALS = {
  ['À'] = 'à', ['Â'] = 'â', ['Ç'] = 'ç', ['É'] = 'é', ['È'] = 'è', ['Ê'] = 'ê',
  ['Î'] = 'î', ['Ô'] = 'ô', ['Û'] = 'û', ['Œ'] = 'œ'
}

local function Lower(s)
  s = string.lower(s)
  for lUpper, lLower in pairs(CAPITALS) do
    s = string.gsub(s, lUpper, lLower)
  end
  return s
end

local function IsLetter(aCode)
  if aCode == nil then
    return false
  end
  if aCode < 128 then
    return string.match(string.char(aCode), '%w') ~= nil
  end
  return (aCode >= 0xC0 and aCode <= 0x24F and aCode ~= 0xD7 and aCode ~= 0xF7)
end

local function CodeBefore(s, aPos)
  local lStart = aPos - 1
  while lStart > 1 and string.byte(s, lStart) >= 0x80 and string.byte(s, lStart) < 0xC0 do
    lStart = lStart - 1
  end
  if lStart < 1 then
    return nil
  end
  return utf8.codepoint(s, lStart)
end

local function CodeAfter(s, aPos)
  if aPos > #s then
    return nil
  end
  return utf8.codepoint(s, aPos)
end

local function ContainsWord(s, aWord)
  local lInit = 1
  while true do
    local lFirst, lLast = string.find(s, aWord, lInit, true)
    if not lFirst then
      return false
    end
    if not IsLetter(CodeBefore(s, lFirst)) and not IsLetter(CodeAfter(s, lLast + 1)) then
      return true
    end
    lInit = lLast + 1
  end
end

local function LoadTerms()
  local lFile = io.open(INDEX_FILE, 'r')
  if not lFile then
    return
  end
  for lLine in lFile:lines() do
    local lLabel, lForms = string.match(lLine, '^%s*(.-)%s*=%s*(.-)%s*$')
    if not lLabel then
      lLabel = string.match(lLine, '^%s*(.-)%s*$')
      lForms = lLabel
    end
    if #lLabel > 0 then
      local lTerm = { label = lLabel, forms = {} }
      for lForm in string.gmatch(lForms, '[^|]+') do
        lForm = string.match(lForm, '^%s*(.-)%s*$')
        if #lForm > 0 then
          table.insert(lTerm.forms, Lower(lForm))
        end
      end
      table.insert(lTerms, lTerm)
    end
  end
  lFile:close()
end

local function ScanTopics()
  local lTopic = 0
  local lText = {}
  local lChapterTitle = ''
  local function Flush()
    if lTopic > 0 then
      local lLower = Lower(table.concat(lText, '\n'))
      local lFound = {}
      for _, lTerm in ipairs(lTerms) do
        for _, lForm in ipairs(lTerm.forms) do
          if ContainsWord(lLower, lForm) then
            table.insert(lFound, lTerm.label)
            break
          end
        end
      end
      lTopicTerms[lTopic] = lFound
    end
    lText = {}
  end
  for i = 2, #arg do
    for s in io.lines(arg[i]) do
      local lLevel = string.match(s, '^(#+) ')
      if lLevel and #lLevel <= 3 then
        Flush()
        lTopic = lTopic + 1
        local lName = string.match(arg[i], '([^/]+)$')
        lFileRes[lName] = lFileRes[lName] or lTopic
        local lTitle = StripNumber((string.gsub(string.match(s, '^#+ (.+)'), '%*', '')))
        if #lLevel == 1 then
          lChapterTitle = lTitle
        end
        lTopicTitles[lTopic] = lTitle
        lTopicChapters[lTopic] = lChapterTitle
        lTitleCounts[lTitle] = (lTitleCounts[lTitle] or 0) + 1
      end
      table.insert(lText, s)
    end
  end
  Flush()
end

local function IndexLines(aTopic)
  local lLines = {}
  local lTitle = lTopicTitles[aTopic]
  if lTitleCounts[lTitle] > 1 then
    lTitle = lTitle .. ' (' .. lTopicChapters[aTopic] .. ')'
  end
  for _, lLabel in ipairs(lTopicTerms[aTopic] or {}) do
    table.insert(lLines, ':i1.' .. Escape(lLabel .. ', ' .. lTitle))
  end
  return table.concat(lLines, '\n')
end

local GREEK = {
  ['α'] = 'a', ['ά'] = 'a', ['ὰ'] = 'a', ['β'] = 'b', ['γ'] = 'g', ['δ'] = 'd',
  ['ε'] = 'e', ['έ'] = 'e', ['ὲ'] = 'e', ['ζ'] = 'z', ['η'] = 'ê', ['ή'] = 'ê',
  ['ὴ'] = 'ê', ['θ'] = 'th', ['ι'] = 'i', ['ί'] = 'i', ['ὶ'] = 'i', ['κ'] = 'k',
  ['λ'] = 'l', ['μ'] = 'm', ['ν'] = 'n', ['ξ'] = 'x', ['ο'] = 'o', ['ό'] = 'o',
  ['ὸ'] = 'o', ['π'] = 'p', ['ρ'] = 'r', ['σ'] = 's', ['ς'] = 's', ['τ'] = 't',
  ['υ'] = 'u', ['ύ'] = 'u', ['ὺ'] = 'u', ['φ'] = 'ph', ['χ'] = 'kh', ['ψ'] = 'ps',
  ['ω'] = 'ô', ['ώ'] = 'ô', ['ὼ'] = 'ô'
}

local function Transliterate(s)
  for lGreek, lLatin in pairs(GREEK) do
    s = string.gsub(s, lGreek, lLatin)
  end
  return s
end

local function Emphasis(s)
  s = string.gsub(s, '%*%*(.-)%*%*', ':hp2.%1:ehp2.')
  s = string.gsub(s, '%*(.-)%*', ':hp1.%1:ehp1.')
  return s
end

local function NoteId(aFile, aLabel)
  return 'fn' .. aFile .. 'n' .. (string.gsub(aLabel, '[^%w]', ''))
end

local function Links(s)
  return (string.gsub(s, '(!?)%[([^%]]+)%]%(([^%)]+)%)', function(aBang, aText, aTarget)
    if aBang ~= '' then
      return nil
    end
    local lName = string.match(aTarget, '^([^#]+%.md)')
    if not lName then
      return nil
    end
    if lFileRes[lName] then
      return string.format(':link reftype=hd res=%d.%s:elink.', lFileRes[lName], aText)
    end
    return aText
  end))
end

local function NoteRefs(s, aFile)
  return (string.gsub(s, '%[%^([^%]]+)%]', function(aLabel)
    lNoteNumber = lNoteNumber + 1
    return string.format(':link reftype=fn refid=%s.(%d):elink.', NoteId(aFile, aLabel), lNoteNumber)
  end))
end

local function FlushNote()
  if not lNote then
    return
  end
  local lText = Emphasis(Escape(Transliterate(table.concat(lNote.lines, ' '))))
  io.write(string.format(':fn id=%s.\n:p.%s\n:efn.\n', lNote.id, lText))
  lNote = nil
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

LoadTerms()
ScanTopics()

for i = 2, #arg do
  for s in io.lines(arg[i]) do
    local lDef, lDefText = string.match(s, '^%[%^([^%]]+)%]:%s*(.*)$')
    if lDef then
      FlushNote()
      lNote = { id = NoteId(i, lDef), lines = { lDefText } }
      goto continue
    end
    if lNote then
      if string.match(s, '^%s+%S') then
        table.insert(lNote.lines, (string.gsub(s, '^%s+', '')))
        goto continue
      elseif #s == 0 then
        goto continue
      end
      FlushNote()
    end

    s = Escape(Transliterate(s))

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

    if string.match(s, '^%d+%. ') then
      if not lOListFlag then
        io.write('.br\n:ol compact.\n')
        lOListFlag = true
      end
      s = ':li.' .. (string.gsub(s, '^%d+%. ', ''))
    else
      if lOListFlag then
        io.write(':eol.\n.br\n')
        lOListFlag = false
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
        local lLevel, lText = string.match(s, '^(#+) (.+)')
        if lLevel and #lLevel <= 3 then
          lRes = lRes + 1
          s = string.format(':h%d res=%d.%s', #lLevel, lRes, StripNumber(lText))
          lIndex = IndexLines(lRes)
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
      
      s = Emphasis(NoteRefs(Links(s), i))

      if lIndex and #lIndex > 0 then
        s = s .. '\n' .. lIndex
      end
    end

    io.write(s .. '\n')
    ::continue::
  end
  FlushNote()
  FlushTable()
end

io.write(':euserdoc.\n')
