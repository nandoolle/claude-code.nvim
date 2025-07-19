# claude-code.nvim

A Neovim plugin that provides seamless integration with Claude Code CLI, allowing you to use Claude directly within your editor through a floating terminal window.

## Features

- **Floating Terminal**: Opens Claude Code in a beautiful floating terminal window
- **Toggle Support**: Easily show/hide the Claude interface with a simple command
- **Smart Window Management**: Automatically closes when you switch to another window
- **Session Persistence**: Maintains your Claude session between toggles

## Requirements

- Neovim 0.5 or higher
- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed and configured

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "nandoolle/claude-code.nvim",
  config = function()
    require("claude-code").setup()
  end,
}
```

#### Lazy Loading with lazy.nvim

For better startup performance, you can configure the plugin to load only when needed:

```lua
{
  "nandoolle/claude-code.nvim",
  cmd = "ClaudeCode",  -- Load when :ClaudeCode is executed
  keys = {
    { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" }
  },
  config = function()
    require("claude-code").setup({
      keybinding = "<leader>cc"  -- Custom keybinding
    })
  end,
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "nandoolle/claude-code.nvim",
  config = function()
    require("claude-code").setup()
  end
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'nandoolle/claude-code.nvim'

" In your init.lua or after plug#end()
lua require('claude-code').setup()
```

## Usage

### Commands

- `:ClaudeCode` - Toggle the Claude Code floating terminal

### Default Keymapping

- `<localleader>cc` - Toggle Claude Code (in normal mode)

## Configuration

The plugin works out of the box with sensible defaults. You can customize it using the setup function:

```lua
require('claude-code').setup({
  -- Custom keybinding (set to nil or false to disable)
  keybinding = "<leader>cc",  -- Default: "<localleader>cc"
})
```

### Configuration Options

- `keybinding` (string|nil): The keybinding to toggle Claude Code. Set to `nil` or `false` to disable the default keybinding.

### Examples

```lua
-- Use a different keybinding
require('claude-code').setup({
  keybinding = "<leader>ai"
})

-- Disable default keybinding (use :ClaudeCode command only)
require('claude-code').setup({
  keybinding = false
})
```

## How It Works

The plugin creates a floating terminal window that runs the `claude` command. The window:

- Takes up 80% of your screen width and height
- Centers itself on the screen
- Has rounded borders for a modern look
- Automatically enters insert mode for immediate interaction
- Closes when you switch to another window

## License

MIT License - see LICENSE file for details

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Issues

If you encounter any problems or have feature requests, please file an issue on the [GitHub repository](https://github.com/nandoolle/claude-code.nvim/issues).

