return {
  'Owen-Dechow/videre.nvim',
  cmd = 'Videre',
  dependencies = {
    'Owen-Dechow/graph_view_yaml_parser',
    'Owen-Dechow/graph_view_toml_parser',
  },
  opts = {
    editor_type = 'floating',
    floating_editor_style = {
      border = 'rounded',
    },
    round_units = true,
    round_connections = true,
    keymap_desc_deliminator = '->',
    simple_statusline = false,
  },
}
