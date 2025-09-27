return {
  on_attach = function(client, _bufnr)
    local pipe_path = client.root_dir .. '/server.pipe'
    if vim.uv.fs_stat(pipe_path) then
      return
    end
    local success, server_addr = pcall(vim.fn.serverstart, pipe_path)
    if not success then
      vim.notify('failed to start godot server pipe: ' .. tostring(server_addr), vim.log.levels.WARN)
    end
  end,
}
