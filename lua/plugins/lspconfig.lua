return {
  "neovim/nvim-lspconfig",
  config = function()
    on_attach = function()
      vim.keymap.set('n', '<leader>ji', vim.lsp.buf.hover, { desc = "Show information" })
      vim.keymap.set('n', '<leader>jh', vim.lsp.buf.signature_help, { desc = "Signature help" })
      vim.keymap.set('n', '<leader>jr', vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set('n', '<a-cr>', vim.lsp.buf.code_action)
      vim.keymap.set('v', '<a-cr>', vim.lsp.buf.code_action)


      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
      vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
      vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
    end

    local lspconfig = require('lspconfig')

    lspconfig.pyright.setup {}
    lspconfig.rust_analyzer.setup {
      experimental = {
        serverStatusNotification = true
      }
    }

    lspconfig.tsserver.setup {
      single_file_support = false,
      root_dir = function(fname)
        local defaults = lspconfig.tsserver.document_config.default_config
        local dir = defaults.root_dir(fname)

        if dir == nil then
          return
        end

        -- Disable for vite projects
        local vite_cfg = lspconfig.util.root_pattern("vite.config.js", "vite.config.ts")(fname)
        if vite_cfg == dir then
          return
        end

        -- Disable for deno functions
        local deno_cfg = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(fname)
        if deno_cfg ~= nil then
          return
        end

        return dir
      end
    }

    -- lspconfig.omnisharp.setup {
    --   cmd = { 'omnisharp' },
    -- }
    lspconfig.biome.setup {
      root_dir = function(fname)
        local defaults = lspconfig.biome.document_config.default_config
        local dir = defaults.root_dir(fname)

        if dir == nil then
          return
        end

        -- Disable for deno functions
        local deno_cfg = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(fname)
        if deno_cfg ~= nil then
          return
        end

        return dir
      end
    }

    lspconfig.svelte.setup {}

    lspconfig.denols.setup {
      filetypes = {
        'typescript'
      },
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    }

    lspconfig.volar.setup {
      init_options = {
        vue = {
          hybridMode = false,
        },
      },
      filetypes = {
        'typescript', 'javascript', 'javascriptreact',
        'typescriptreact', 'vue', 'json',
      },
      root_dir = function(fname)
        local dir = lspconfig.util.root_pattern("vite.config.ts", "vite.config.js")(fname)
        if dir == nil then
          return
        end

        -- Disable for deno functions
        local deno_cfg = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(fname)
        if deno_cfg ~= nil then
          return
        end

        return dir
      end
    }

    lspconfig.tailwindcss.setup {}

    vim.diagnostic.config({
      virtual_text = false,
    })

    -- FIXME: Is there a global default setup?
    on_attach()
  end
}
