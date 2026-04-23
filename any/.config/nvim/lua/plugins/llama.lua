return {
  'ggml-org/llama.vim',
  init = function(_, opts)
    local key_file = '/dev/shm/llama.vim_key.txt'
    local file = io.open(key_file, 'r')
    if file then
      local api_key = file:read('*line')
      file:close()
      vim.g.llama_config = {
        auto_inst = true,
        api_key = api_key,
        model_inst = 'unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q4_K_XL',
        model_fim = 'unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q4_K_XL',
      }
    else
      vim.notify("llama.vim: api_key not found in /dev/shm/llama.vim_key.txt", vim.log.levels.WARN)
    end
  end,
  config = function(_, opts)
    local set_llama_hl = function()
      vim.api.nvim_set_hl(0, "llama_hl_fim_hint", {fg = "#b33e00", ctermfg = 202})
      vim.api.nvim_set_hl(0, "llama_hl_fim_info", {fg = "#555555", ctermfg = 219})
    end

    set_llama_hl()

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        set_llama_hl()
      end,
    })
  end,
}
