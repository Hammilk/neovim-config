-- lua/plugins/modules/lsp_signature.lua
return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",  -- load on entering Insert mode for efficiency&#8203;:contentReference[oaicite:1]{index=1}
  opts = {
    bind = true,           -- mandatory, ensures border and doc highlight work&#8203;:contentReference[oaicite:2]{index=2}
    floating_window = true, -- show diagnostics in a floating popup (not virtual text)&#8203;:contentReference[oaicite:3]{index=3}
    hint_enable = false,   -- disable inline hints to use only floating popups&#8203;:contentReference[oaicite:4]{index=4}
    floating_window_above_cur_line = true,  -- try to show popup above the current line (avoid covering code)
    handler_opts = {
      border = "rounded"   -- add a rounded border to the signature popup window
    }
  }
}

