# vim-rustfmt

Integrates with [rustfmt](https://github.com/rust-lang/rustfmt) so every time
you save a Rust source file it gets automatically prettified.

Simply using `:%!rustfmt` replaces your whole source file with an error message
from **rustfmt** when you happen to have a syntax error in your code, this
plugin manages that annoyance.


## Installation

Compatible with `Vundle`, `Pathogen`, `Vim-plug`, etc.


## Usage

By default, *vim-rustfmt* will format your code automatically when saving a
Rust source file, but you can use the `:Rustfmt` command at any time to
format the current file.

To apply *rustfmt* on a range, either write the range manually or visually
select the desired code and then invoke `:Rustfmt`.

Use `:RustfmtEnable`, `:RustfmtDisable`, `:RustfmtToggle` to enable, disable, or
toggle running `rustfmt` on save.


## Configuration

Trigger *rustfmt* when saving (default = 1):

```vim
g:rustfmt_on_save = 1
```

Rust edition to use (default = '2018'):

```vim
g:rustfmt_edition = '2018'
```

Backup modified files (default = 0):

```vim
g:rustfmt_backup = 0
```
