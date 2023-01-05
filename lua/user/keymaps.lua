local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

local M = {}

M.main = function()
  -- moving among splits
  -- map("n", "<C-h>", "<C-w>h")
  -- map("n", "<C-j>", "<C-w>j")
  -- map("n", "<C-k>", "<C-w>k")
  -- map("n", "<C-l>", "<C-w>l")
  -- map("i", "<C-h>", [[<C-\><C-N><C-w>h]])
  -- map("i", "<C-j>", [[<C-\><C-N><C-w>j]])
  -- map("i", "<C-k>", [[<C-\><C-N><C-w>k]])
  -- map("i", "<C-l>", [[<C-\><C-N><C-w>l]])
  -- map("t", "<C-h>", [[<C-\><C-N><C-w>h]])
  -- map("t", "<C-j>", [[<C-\><C-N><C-w>j]])
  -- map("t", "<C-k>", [[<C-\><C-N><C-w>k]])
  -- map("t", "<C-l>", [[<C-\><C-N><C-w>l]])

  -- visual movement but not in operator pending mode
  map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
  map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

  -- toggle wrap
  map("n", "<F10>", ":setlocal wrap!<CR>")

  -- create splits
  -- map("n", "<leader>v", ":vsplit<CR>")
  -- map("n", "<leader>s", ":split<CR>")

  -- move block of text
  map("n", "<A-k>", ":m .-2<CR>==")
  map("n", "<A-j>", ":m .+1<CR>==")
  map("i", "<A-k>", "<ESC>:m .-2<CR>==gi")
  map("i", "<A-j>", "<ESC>:m .+1<CR>==gi")
  map("v", "<A-k>", ":m '<-2<CR>gv=gv")
  map("v", "<A-j>", ":m '>+1<CR>gv=gv")

  -- better indenting
  map("v", "<", "<gv")
  map("v", ">", ">gv")

  -- better yanking
  -- map("n", "Y", "y$") --> default
  map("n", "<leader>y", ":%y<CR>") --> copy whole file
  map("v", "<leader>p", '"_dP') --> replace selection with clipboard without sending replaced text to clipboard
  map("n", "x", '"_x') --> do not send deleted char to clipboard
  map("v", "x", '"_x') --> send selecction to blackhole register

  -- quickfix list TODO
  -- location list TODO

  -- save me
  map("n", "<leader>q", ":bd<CR>")
  map("n", "<leader>w", ":w<CR>")
  vim.api.nvim_create_user_command("W", "w", {})
  vim.api.nvim_create_user_command("Wq", "wq", {})
  vim.api.nvim_create_user_command("Q", "q<bang>", { bang = true })

  -- terminal config
  map("n", "<leader>tt", ":term<CR>")
  map("n", "<leader>tv", ":60vsplit +term<CR>")
  map("n", "<leader>ts", ":20split +term<CR>")

  -- escape terminal mode
  -- map("t", "<Esc>", [[<C-\><C-n>]])

  -- resizing
  map("n", "<C-Up>", ":resize +2<CR>")
  map("n", "<C-Down>", ":resize -2<CR>")
  map("n", "<C-Left>", ":vertical resize -2<CR>")
  map("n", "<C-Right>", ":vertical resize +2<CR>")

  -- toggle indent size
  map("n", "<F9>", function()
    if vim.opt["shiftwidth"]._value == 2 then
      vim.opt["shiftwidth"] = 4
      vim.opt["tabstop"] = 4
    elseif vim.opt["shiftwidth"]._value == 4 then
      vim.opt["shiftwidth"] = 2
      vim.opt["tabstop"] = 2
    end
  end)
end

M.lsp = function(bufnr)
  local function buf_map(mode, lhs, rhs)
    map(mode, lhs, rhs, { buffer = bufnr })
  end

  buf_map("n", "gD", vim.lsp.buf.declaration)
  buf_map("n", "gd", vim.lsp.buf.definition)
  buf_map("n", "K", vim.lsp.buf.hover)
  buf_map("n", "gI", vim.lsp.buf.implementation)
  buf_map("n", "gs", vim.lsp.buf.signature_help)
  -- buf_map("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder)
  -- buf_map("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder)
  -- buf_map("n", "<leader>lwl", vim.pretty_print(vim.lsp.buf.list_workspace_folders()))
  buf_map("n", "gy", vim.lsp.buf.type_definition)
  buf_map("n", "<leader>lr", vim.lsp.buf.rename)
  buf_map("n", "<leader>la", vim.lsp.buf.code_action)
  buf_map("n", "gr", vim.lsp.buf.references)
  buf_map("n", "gl", vim.diagnostic.open_float)
  buf_map("n", "<leader>ll", vim.diagnostic.setloclist)
  buf_map("n", "[d", vim.diagnostic.goto_prev)
  buf_map("n", "]d", vim.diagnostic.goto_next)
  buf_map({ "n", "v" }, "gq", function()
    vim.lsp.buf.format({ async = true })
  end)
end

M.cmp = function(cmp)
  return {
    ["<C-n"] = cmp.mapping.select_next_item(),
    ["<C-p"] = cmp.mapping.select_prev_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),

    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = false }),

    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    -- elseif luasnip.expand_or_jumpable() then
    --   luasnip.expand_or_jump()
    -- elseif has_words_before() then
    --   cmp.complete()
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
    --
    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    -- elseif luasnip.jumpable(-1) then
    --   luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
  }
end

M.luasnip = function(luasnip)
  map({ "i", "s" }, "<C-k>", function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    end
  end)

  map({ "i", "s" }, "<C-j>", function()
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end)

  -- map("i", "<C-l>", function ()
  --   if luasnip.choice_active() then
  --     luasnip.change_choice(1)
  --   end
  -- end)
end

M.tabline = function()
  -- map("n", "<leader>b", "<Plug>(cokeline-pick-focus)")
  map("n", "<leader>b", ":BufferLinePick<CR>")
  map({ "n", "i" }, "<A-b>", "<cmd>BufferLineCycleNext<CR>")
  map({ "n", "i" }, "<A-B>", "<cmd>BufferLineCyclePrev<CR>")
  map("n", "]b", ":BufferLineMoveNext<CR>")
  map("n", "[b", ":BufferLineMovePrevious<CR>")
end

M.neotree = {
  main = function()
    map("n", "<leader>n", ":Neotree toggle=true<CR>")
  end,

  global = {
    ["<cr>"] = "open",
    ["<esc>"] = "revert_preview",
    ["P"] = { "toggle_preview", config = { use_float = true } },
    ["s"] = "open_split",
    ["v"] = "open_vsplit",
    ["t"] = "open_tabnew",
    ["C"] = "close_node",
    ["z"] = "close_all_nodes",
    ["Z"] = "expand_all_nodes",
    ["a"] = {
      "add",
      -- some commands may take optional config options, see `:h neo-tree-mappings` for details
      config = {
        show_path = "absolute", -- "none", "relative", "absolute"
      },
    },
    -- ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
    ["d"] = "delete",
    ["r"] = "rename",
    ["y"] = "copy_to_clipboard",
    ["x"] = "cut_to_clipboard",
    ["p"] = "paste_from_clipboard",
    -- ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
    ["c"] = {
      "copy",
      config = {
        show_path = "absolute", -- "none", "relative", "absolute"
      },
    },
    ["m"] = {
      "move",
      config = {
        show_path = "absolute", -- "none", "relative", "absolute"
      },
    }, -- takes text input for destination, also accepts the optional config.show_path option like "add".
    ["q"] = "close_window",
    ["R"] = "refresh",
    ["?"] = "show_help",
    ["<"] = "prev_source",
    [">"] = "next_source",
  },
  filesystem = {
    ["<bs>"] = "navigate_up",
    ["."] = "set_root",
    ["H"] = "toggle_hidden",
    ["/"] = "fuzzy_finder",
    ["D"] = "fuzzy_finder_directory",
    ["f"] = "filter_on_submit",
    ["<c-x>"] = "clear_filter",
    ["[g"] = "prev_git_modified",
    ["]g"] = "next_git_modified",
  },
  buffers = {
    ["bd"] = "buffer_delete",
    ["<bs>"] = "navigate_up",
    ["."] = "set_root",
  },
  git_status = {
    ["gA"] = "git_add_all",
    ["gu"] = "git_unstage_file",
    ["ga"] = "git_add_file",
    ["gr"] = "git_revert_file",
    ["gc"] = "git_commit",
    ["gp"] = "git_push",
    ["gg"] = "git_commit_and_push",
  },
}

M.gitsigns = function(bufnr)
  local gs = package.loaded.gitsigns
  local function buf_map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    map(mode, lhs, rhs, opts)
  end

  buf_map("n", "]g", function()
    if vim.wo.diff then
      return "]g"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, { expr = true })

  buf_map("n", "[g", function()
    if vim.wo.diff then
      return "[g"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, { expr = true })

  buf_map({ "n", "v" }, "<leader>ga", ":Gitsigns stage_hunk<CR>")
  buf_map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
  buf_map("n", "<leader>gA", gs.stage_buffer)
  buf_map("n", "<leader>gR", gs.reset_buffer)
  buf_map("n", "<leader>gu", gs.undo_stage_hunk)
  buf_map("n", "<leader>gp", gs.preview_hunk)
  buf_map("n", "<leader>gb", function()
    gs.blame_line({ full = true })
  end)
  buf_map("n", "<leader>gtb", gs.toggle_current_line_blame)
  buf_map("n", "<leader>gd", gs.diffthis)
  -- buf_map("n", "<leader>gD", function() gs.diffthis('~') end) --> diff with parent of head
  buf_map("n", "<leader>gtd", gs.toggle_deleted)
  buf_map("n", "<leader>gtl", gs.toggle_linehl)
  buf_map("n", "<leader>gl", gs.setloclist)
  buf_map("n", "<leader>gq", function()
    gs.setqflist({ target = "all" })
  end)

  -- text object
  buf_map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end

M.comment = {
  ---LHS of toggle mappings in NORMAL mode
  toggler = {
    ---Line-comment toggle keymap
    line = "gcc",
    ---Block-comment toggle keymap
    block = "gbc",
  },
  ---LHS of operator-pending mappings in NORMAL and VISUAL mode
  opleader = {
    ---Line-comment keymap
    line = "gc",
    ---Block-comment keymap
    block = "gb",
  },
  ---LHS of extra mappings
  extra = {
    ---Add comment on the line above
    above = "gcO",
    ---Add comment on the line below
    below = "gco",
    ---Add comment at the end of line
    eol = "gcA",
  },
}

M.telescope = function(telescope_builtin)
  map("n", "<leader>ff", telescope_builtin.find_files)
  map("n", "<leader>fg", telescope_builtin.live_grep)
  map("n", "<leader>fh", telescope_builtin.oldfiles)
end

return M
