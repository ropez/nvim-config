return {
  "neovim/nvim-lspconfig",
  config = function()
    on_attach = function()
      vim.keymap.set('n', '<leader>ji', vim.lsp.buf.hover, { desc = "Show information" })
      vim.keymap.set('n', '<leader>jh', vim.lsp.buf.signature_help, { desc = "Signature help" })
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set('n', '<a-cr>', vim.lsp.buf.code_action)
      vim.keymap.set('v', '<a-cr>', vim.lsp.buf.code_action)


      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
      -- vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
      -- vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
    end

    local lspconfig = require('lspconfig')

    -- lspconfig.dartls.setup {}

    vim.lsp.enable('pyright');

    vim.lsp.enable('tofu_ls');
    vim.lsp.config('tofu_ls', {
      filetypes = {
        "opentofu",
        "opentofu-vars",
        "terraform",
        "terraform-vars",
      }
    });

    vim.lsp.enable('rust_analyzer')
    vim.lsp.config('rust_analyzer', {
      experimental = {
        serverStatusNotification = true
      },

      settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
          },
        },
      },
    })

    vim.lsp.enable('ts_ls')
    vim.lsp.config('ts_ls', {
      single_file_support = false,
      init_options = {
        plugins = {
          -- Fragile setup: If node version is changed, it breaks
          -- Requires that both @vue/typescript-plugin and @vue/language-server is installed, and the same version
          {
            name = "@vue/typescript-plugin",
            location = "/home/robin/.asdf/installs/nodejs/22.11.0/lib/node_modules/@vue/typescript-plugin",
            languages = {"javascript", "typescript", "vue"},
          },
        }
      },
      filetypes = {
        "javascript",
        "typescript",
        "vue",
      },
      -- root_dir = function(fname)
      --   local defaults = lspconfig.ts_ls.document_config.default_config
      --   local dir = defaults.root_dir(fname)
      --
      --   if dir == nil then
      --     return
      --   end
      --
      --   -- -- Disable for vue projects
      --   -- local vite_cfg = lspconfig.util.root_pattern("vite.config.ts")(fname)
      --   -- if vite_cfg == dir then
      --   --   for line in io.lines(vite_cfg .. '/vite.config.ts') do
      --   --     if string.find(line, "plugin-vue", 1, true) then
      --   --       return
      --   --     end
      --   --   end
      --   -- end
      --
      --   -- Disable for deno functions
      --   local deno_cfg = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(fname)
      --   if deno_cfg ~= nil then
      --     return
      --   end
      --
      --   return dir
      -- end
    })

    -- vim.lsp.enable('biome')
    -- vim.lsp.config('biome', {
    --   root_dir = function(fname)
    --     local defaults = lspconfig.biome.document_config.default_config
    --     local dir = defaults.root_dir(fname)
    --
    --     if dir == nil then
    --       return
    --     end
    --
    --     -- Disable for deno functions
    --     local deno_cfg = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(fname)
    --     if deno_cfg ~= nil then
    --       return
    --     end
    --
    --     -- Disable for svelte
    --     local svelte_dir = lspconfig.svelte.document_config.default_config.root_dir(fname)
    --     if svelte_dir ~= nil then
    --       return
    --     end
    --
    --     return dir
    --   end
    -- })

    vim.lsp.enable('svelte')
    vim.lsp.config('svelte', {
      -- https://github.com/neovim/nvim-lspconfig/issues/725
      on_attach = function(client)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
      end
    })

    vim.lsp.enable('denols')
    vim.lsp.config('denols', {
      filetypes = {
        'typescript'
      },
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    })

    vim.lsp.enable('kotlin_language_server');
    vim.lsp.enable('tailwindcss');
    vim.lsp.enable('gopls')

    vim.diagnostic.config({
      virtual_text = false,
    })

    -- FIXME: Is there a global default setup?
    on_attach()
  end
}
