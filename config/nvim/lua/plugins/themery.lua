return {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      require("themery").setup({
        -- add the config here
        themes = {"astrojupiter", "astromars", "astrodark", "astrolight", "catppuccin-mocha"}, -- Your list of installed colorschemes.
        livePreview = true, -- Apply theme while picking. Default to true.
      })
    end
  }
