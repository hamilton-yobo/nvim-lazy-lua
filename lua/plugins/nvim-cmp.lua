return {
  "hrsh7th/nvim-cmp",
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')

    require("luasnip/loaders/from_vscode").lazy_load()

    vim.opt.completeopt = "menu,menuone,noselect"

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false}),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- lsp
        { name = "luasnip" }, -- luasnippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system path
      }),
      -- configure lspkind for vs-code like icons
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end,
  dependencies = {
    "onsails/lspkind.nvim",
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release
      version = "2.*", -- Replace <CurrentMajor> by the latest release
      -- install jsregexp (optional!)
      build = "make install_jsregexp",
    },
  },
}
-- Autocompletion
-- return {
--    'hrsh7th/nvim-cmp',
--    event = 'InsertEnter',
--    dependencies = {
--      {'L3MON4D3/LuaSnip'},
--    },
--    config = function()
--      -- Here is where you configure the autocompletion settings.
--      local lsp_zero = require('lsp-zero')
--      lsp_zero.extend_cmp()
--
--      -- And you can configure cmp even more, if you want to.
--      local cmp = require('cmp')
--      local cmp_action = lsp_zero.cmp_action()
--
--      cmp.setup({
--        formatting = lsp_zero.cmp_format({details = true}),
--        mapping = cmp.mapping.preset.insert({
--          ['<C-Space>'] = cmp.mapping.complete(),
--          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
--          ['<C-d>'] = cmp.mapping.scroll_docs(4),
--          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
--          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
--        })
--      })
--    end
--  },
--
