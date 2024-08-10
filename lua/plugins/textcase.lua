return {
  "johmsalas/text-case.nvim",
  config = function()
    local textcase = require("textcase")

    textcase.setup({ default_keymappings_enabled = false })

    require("which-key").add({
      { "C_", function() textcase.current_word("to_snake_case") end, desc = "snake_case", mode = "n"},
      { "C_", function() textcase.operator("to_snake_case") end, desc = "snake_case", mode = "v"},

      { "C-", function() textcase.current_word("to_dash_case") end, desc = "dash-case", mode = "n"},
      { "C-", function() textcase.operator("to_dash_case") end, desc = "dash-case", mode = "v"},

      { "Cc", function() textcase.current_word("to_camel_case") end, desc = "camelCase", mode = "n" },
      { "Cc", function() textcase.operator("to_camel_case") end, desc = "camelCase", mode = "v" },

      { "CC", function() textcase.current_word("to_constant_case") end, desc = "CONSTANT_CASE", mode = "n" },
      { "CC", function() textcase.operator("to_constant_case") end, desc = "CONSTANT_CASE", mode = "v" },

      { "Cp", function() textcase.current_word("to_pascal_case") end, desc = "PascalCase", mode = "n"},
      { "Cp", function() textcase.operator("to_pascal_case") end, desc = "PascalCase", mode = "v"},

      { "Cs", function() textcase.current_word("to_phrase_case") end, desc = "Sentence case", mode = "n"},
      { "Cs", function() textcase.operator("to_phrase_case") end, desc = "Sentence case", mode = "v"},

      { "Ct", function() textcase.current_word("to_title_case") end, desc = "Title Case", mode = "n"},
      { "Ct", function() textcase.operator("to_title_case") end, desc = "Title Case", mode = "v"},

      { "Cl", function() textcase.current_word("to_lower_case") end, desc = "lower case", mode = "n"},
      { "Cl", function() textcase.operator("to_lower_case") end, desc = "lower case", mode = "v"},

      { "Cu", function() textcase.current_word("to_upper_case") end, desc = "UPPER CASE", mode = "n"},
      { "Cu", function() textcase.operator("to_upper_case") end, desc = "UPPER CASE", mode = "v"},

      noremap = true
    })
  end
}
