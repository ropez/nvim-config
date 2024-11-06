return {
  'seblj/roslyn.nvim',

  opts = {
    filewatching = false,
    broad_search = true,
    choose_sln = function(sln)
        local item = vim.iter(sln):find(function(item)
            if string.match(item, "SmartDok.Luna.Api.sln") then
                return item
            end
        end)
        if not item then return sln[1] else return item end
    end,
  },
}
