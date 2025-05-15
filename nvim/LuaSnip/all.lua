local ls = require 'luasnip'
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
return {
  -- A snippet that expands the trigger "hi" into the string "Hello, world!".
  s({ trig = 'hi' }, { t 'Hello, world!' }),

  -- To return multiple snippets, use one `return` statement per snippet file
  -- and return a table of Lua snippets.
  s({ trig = 'foo' }, { t 'Another snippet.' }),

  -- example multiline node
  s({ trig = 'lines', dscr = 'example multiline text node' }, {
    t { 'line 1', 'line 2', 'line 3' },
  }),

  -- example insert node use
  s({ trig = 'tt', dscr = '\\texttt{}' }, {
    t '\\texttt{',
    i(1),
    t '}',
  }),

  -- fmta (format anglebracket)
  s(
    { trig = 'eq', dscr = 'LaTeX equation' },
    fmta(
      [[
        \begin{<>}
          <>
        \end{<>}
      ]],
      { i(1), i(0), rep(1) }
    )
  ),

  -- greek letters
  s({ trig = ';a', snippetType = 'autosnippet' }, { t '\\alpha' }),
  s({ trig = ';b', snippetType = 'autosnippet' }, { t '\\beta' }),
  s({ trig = ';d', snippetType = 'autosnippet' }, { t '\\delta' }),
  s({ trig = ';g', snippetType = 'autosnippet' }, { t '\\gamma' }),
}
