
M = {}

local highlight = function(name, def)
  return { name = name, def = def }
end

local defaultFg = "#c6c8d1"
local defaultBg = "#161821"
local edgeGrey = "#3d435c"
local grey3 = "#2e313f"
local grey4 = "#2e3244"
local black = "#0f1117"
local grey = "#1e2132"
local red = "#e27878"
local yellow = "#e2a478"
local green = "#b4be82"
local cyan = "#89b8c2"
local blue = "#84a0c6"
local lightBlue = "#8b98b6"
local purple = "#a093c7"

local _colors = {
  highlight("Normal", { bg = "NONE", fg = defaultFg }),
  highlight("NormalNC", { bg = grey, fg = defaultFg }),

  highlight("ColorColumn", { bg = grey, fg = "NONE" }),
  highlight("CursorColumn", { bg = grey, fg = "NONE" }),
  highlight("CursorLine", { bg = grey, fg = "NONE" }),
  highlight("Comment", { fg = "#6b7089" }),
  highlight("Conceal", { bg = defaultBg, fg = "#6b7089" }),
  highlight("Constant", { fg = purple }),
  highlight("Cursor", { bg = defaultFg, fg = defaultBg }),
  highlight("CursorLineNr", { bg = "#2a3158", fg = "#cdd1e6" }),
  highlight("Delimiter", { fg = defaultFg }),

  highlight("DiffAdd", { bg = "#45493e", fg = "#c0c5b9" }),
  highlight("DiffChange", { bg = "#384851", fg = "#b3c3cc" }),
  highlight("DiffDelete", { bg = "#53343b", fg = "#ceb0b6" }),
  highlight("DiffText", { bg = "#5b7881", fg = defaultFg }),

  highlight("Directory", { fg = cyan }),
  highlight("Error", { bg = defaultBg, fg = red }),
  highlight("ErrorMsg", { bg = defaultBg, fg = red }),
  highlight("WarningMsg", { bg = defaultBg, fg = red }),
  highlight("EndOfBuffer", { fg = "#242940" }),
  highlight("NonText", { fg = "#242940" }),
  highlight("Whitespace", { fg = "#242940" }),
  highlight("Folded", { bg = grey, fg = "#686f9a" }),
  highlight("FoldColumn", { bg = grey, fg = "#444b71" }),
  highlight("Function", { fg = blue }),
  highlight("Identifier", { fg = cyan }),
  highlight("Ignore", { bg = "NONE", fg = "NONE" }),
  highlight("Include", { fg = blue }),
  highlight("IncSearch", { reverse = true, fg = "NONE" }),
  highlight("LineNr", { bg = "NONE", fg = "#444b71" }),
  highlight("MatchParen", { bg = "#3e445e", fg = "#ffffff" }),
  highlight("ModeMsg", { fg = "#6b7089" }),
  highlight("MoreMsg", { fg = green }),
  highlight("Operator", { fg = blue }),
  highlight("Pmenu", { bg = "#3d425b", fg = defaultFg }),
  highlight("PmenuSbar", { bg = "#3d425b", fg = "NONE" }),
  highlight("PmenuSel", { bg = "#5b6389", fg = "#eff0f4" }),
  highlight("PmenuThumb", { bg = defaultFg, fg = "NONE" }),
  highlight("PreProc", { fg = green }),
  highlight("Question", { fg = green }),
  highlight("QuickFixLine", { bg = "#272c42", fg = defaultFg }),
  highlight("Search", { bg = "#e4aa80", fg = "#392313" }),
  highlight("SignColumn", { bg = "NONE", fg = "#444b71" }),
  highlight("Special", { fg = green }),
  highlight("SpecialKey", { fg = "#515e97" }),
  highlight("SpellBad", { fg = "NONE" }),
  highlight("SpellCap", { fg = "NONE" }),
  highlight("SpellLocal", { fg = "NONE" }),
  highlight("SpellRare", { fg = "NONE" }),
  highlight("Statement", { fg = blue }),
  highlight("StorageClass", { fg = blue }),
  highlight("String", { fg = cyan }),
  highlight("Structure", { fg = blue }),
  highlight("StatusLine", { bg = black, fg = black, reverse = true }),
  highlight("StatusLineNC", { bg = black, fg = black, reverse = false }),
  highlight("TabLine", { bg = black, fg = "#3e445e" }),
  highlight("TabLineFill", { reverse = true, bg = "#3e445e", fg = black }),
  highlight("TabLineSel", { bg = defaultBg, fg = "#9a9ca5" }),
  highlight("Title", { fg = yellow }),
  highlight("Todo", { bg = "#45493e", fg = green }),
  highlight("Type", { fg = blue }),
  highlight("Underlined", { underline = true, fg = blue }),
  highlight("WinSeparator", { bg = "NONE", fg = blue }),
  highlight("Visual", { bg = "#272c42", fg = "NONE" }),
  highlight("VisualNOS", { bg = "#272c42", fg = "NONE" }),
  highlight("WildMenu", { bg = "#d4d5db", fg = "#17171b" }),
  highlight("diffAdded", { fg = green }),
  highlight("diffRemoved", { fg = red }),
  highlight("DiagnosticUnderlineInfo", { }),
  highlight("DiagnosticInfo", { fg = cyan }),
  highlight("DiagnosticSignInfo", { bg = "NONE", fg = cyan }),
  highlight("DiagnosticUnderlineHint", { }),
  highlight("DiagnosticHint", { fg = "#6b7089" }),
  highlight("DiagnosticSignHint", { bg = "NONE", fg = "#6b7089" }),
  highlight("DiagnosticUnderlineWarn", {  }),
  highlight("DiagnosticWarn", { fg = yellow }),
  highlight("DiagnosticSignWarn", { bg = "NONE", fg = yellow }),
  highlight("DiagnosticUnderlineError", { }),
  highlight("DiagnosticError", { fg = red }),
  highlight("DiagnosticSignError", { bg = "NONE", fg = red }),
  highlight("DiagnosticFloatingHint", { bg = "#3d425b", fg = defaultFg }),

  -- Treesitter
  highlight("TSFunction", { fg = "#a3adcb" }),
  highlight("TSFunctionBuiltin", { fg = "#a3adcb" }),
  highlight("TSFunctionMacro", { fg = "#a3adcb" }),
  highlight("TSMethod", { fg = "#a3adcb" }),
  highlight("TSURI", { fg = cyan  }),
  highlight("TSAttribute", { fg = green }),
  highlight("TSBoolean", { fg = purple }),
  highlight("TSCharacter", { fg = purple }),
  highlight("TSComment", { fg = "#6b7089" }),
  highlight("TSConstructor", { fg = defaultFg }),
  highlight("TSConditional", { fg = blue }),
  highlight("TSConstant", { fg = purple }),
  highlight("TSConstBuiltin", { fg = purple }),
  highlight("TSConstMacro", { fg = purple }),
  highlight("TSError", { bg = defaultBg, fg = red }),
  highlight("TSException", { fg = blue }),
  highlight("TSField", { fg = defaultFg }),
  highlight("TSFloat", { fg = purple }),
  highlight("TSInclude", { fg = blue }),
  highlight("TSKeyword", { fg = blue }),
  highlight("TSKeywordFunction", { fg = blue }),
  highlight("TSLabel", { fg = green }),
  highlight("TSNamespace", { fg = blue }),
  highlight("TSNumber", { fg = purple }),
  highlight("TSOperator", { fg = defaultFg }),
  highlight("TSParameter", { fg = defaultFg }),
  highlight("TSParameterReference", { fg = defaultFg }),
  highlight("TSProperty", { fg = defaultFg }),
  highlight("TSPunctDelimiter", { fg = defaultFg }),
  highlight("TSPunctBracket", { fg = defaultFg }),
  highlight("TSPunctSpecial", { fg = green }),
  highlight("TSRepeat", { fg = blue }),
  highlight("TSString", { fg = cyan }),
  highlight("TSStringRegex", { fg = cyan }),
  highlight("TSStringEscape", { fg = green }),
  -- highlight("TSTag" htmlTagName),
  -- highlight("TSTagAttribute" htmlArg),
  -- highlight("TSTagDelimiter" htmlTagName),
  highlight("TSText", { fg = defaultFg }),
  highlight("TSTitle", { fg = yellow }),
  highlight("TSType", { fg = blue }),
  highlight("TSTypeBuiltin", { fg = blue }),
  highlight("TSVariable", { fg = defaultFg }),
  highlight("TSVariableBuiltin", { fg = blue }),
}

function M.colors()
  for _, hi in ipairs(_colors) do
    vim.api.nvim_set_hl(0, hi.name, hi.def)
  end
end

return M
