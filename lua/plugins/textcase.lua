return {
  "johmsalas/text-case.nvim",
  config = function()
    local textcase = require("textcase")

    textcase.setup({ default_keymappings_enabled = false })

    require("which-key").add({
      { "<leader>C", group = "Casing" },

      { "<leader>C_", function() textcase.current_word("to_snake_case") end, desc = "snake_case", mode = "n" },
      { "<leader>C_", function() textcase.operator("to_snake_case") end, desc = "snake_case", mode = "v"},

      { "<leader>C-", function() textcase.current_word("to_dash_case") end, desc = "dash-case", mode = "n"},
      { "<leader>C-", function() textcase.operator("to_dash_case") end, desc = "dash-case", mode = "v"},

      { "<leader>Cc", function() textcase.current_word("to_camel_case") end, desc = "camelCase", mode = "n" },
      { "<leader>Cc", function() textcase.operator("to_camel_case") end, desc = "camelCase", mode = "v" },

      { "<leader>CC", function() textcase.current_word("to_constant_case") end, desc = "CONSTANT_CASE", mode = "n" },
      { "<leader>CC", function() textcase.operator("to_constant_case") end, desc = "CONSTANT_CASE", mode = "v" },

      { "<leader>Cp", function() textcase.current_word("to_pascal_case") end, desc = "PascalCase", mode = "n"},
      { "<leader>Cp", function() textcase.operator("to_pascal_case") end, desc = "PascalCase", mode = "v"},

      { "<leader>Cs", function() textcase.current_word("to_phrase_case") end, desc = "Sentence case", mode = "n"},
      { "<leader>Cs", function() textcase.operator("to_phrase_case") end, desc = "Sentence case", mode = "v"},

      { "<leader>Ct", function() textcase.current_word("to_title_case") end, desc = "Title Case", mode = "n"},
      { "<leader>Ct", function() textcase.operator("to_title_case") end, desc = "Title Case", mode = "v"},

      { "<leader>Cl", function() textcase.current_word("to_lower_case") end, desc = "lower case", mode = "n"},
      { "<leader>Cl", function() textcase.operator("to_lower_case") end, desc = "lower case", mode = "v"},

      { "<leader>Cu", function() textcase.current_word("to_upper_case") end, desc = "UPPER CASE", mode = "n"},
      { "<leader>Cu", function() textcase.operator("to_upper_case") end, desc = "UPPER CASE", mode = "v"},
    })
  end
}
