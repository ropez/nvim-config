return {
  'seblj/roslyn.nvim',

  opts = {
    filewatching = "off",
    broad_search = true,
    ignore_target = function(sln)
      return string.match(sln, "SmartDok.sln") ~= nil
    end,
  },

  config = function(_, opts)
    require("roslyn").setup(opts)

    vim.lsp.config("roslyn", {
      cmd = {
        "dotnet",
        vim.fs.joinpath(vim.fn.stdpath("data"), "roslyn", "Microsoft.CodeAnalysis.LanguageServer.dll"),
        "--logLevel=Warning",
        "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        "--stdio",
      },
    })
  end,
}
