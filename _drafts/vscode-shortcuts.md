## Navigation

[https://dev.to/macmacky/my-vscode-shortcuts-settings-and-extensions-for-productivity-3chd](https://dev.to/macmacky/my-vscode-shortcuts-settings-and-extensions-for-productivity-3chd)

| Tastenkombination                                                     | Beschreibung                                                                  |
|:--------------------------------------------------------------------- |:----------------------------------------------------------------------------- |
| <kbd></kbd>                                                           | Go to class; by first letter, i.e. `BF` for `BarFactory`; to line `BF:40`     |
| <kbd></kbd>                                                           | Go to class, toggle by project files; can go to folder by doing `/baz_folder` |
| <kbd></kbd>                                                           | Any symbol; can filter by nameSpace, i.e. `FBF.getFoo`                        |
| <kbd></kbd>                                                           | Project structure (folders), can use keyboard to navigate or find by word     |
| <kbd>Crtl</kbd> + <kbd>Shift</kbd> + <kbd>F</kbd>                     | Search everywhere                                                             |
| <kbd></kbd>                                                           | Project structure sidebar (symbol based)                                      |
| <kbd></kbd>                                                           | Project structure popup                                                       |
| <kbd>Crtl</kbd> + <kbd>Shift</kbd> + <kbd>O</kbd>                     | Symbols current file.  Type `:` to sort                                       |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>↓</kbd>/<kbd>↑</kbd>         | Go to next/previous member (extension)                                        |
| <kbd>Crtl</kbd> + <kbd>E</kbd>                                        | Recent files                                                                  |
| <kbd>Crtl</kbd> + <kbd>K</kbd> <kbd>Crtl</kbd> + <kbd>Q</kbd>         | Jump to last edited file                                                      |
| <kbd>Crtl</kbd> + <kbd>Tab</kbd>                                      | Switch between open editors                                                   |
| <kbd></kbd>                                                           | Jump to navigation bar; navigate with keys                                    |
| <kbd>F12</kbd>                                                        | Go to definition                                                              |
| <kbd>Alt</kbd> + <kbd>F12</kbd>                                       | Go to declaration                                                             |
| <kbd>Shift</kbd> + <kbd>F12</kbd>                                     | Peek References                                                               |
| <kbd></kbd>                                                           | Parameter info                                                                |
| <kbd>Ctrl</kbd> + <kbd>K</kbd> <kbd>Ctrl</kbd> + <kbd>I</kbd>         | Quickdocumentation                                                            |
| <kbd></kbd>                                                           | Super definition/decleration                                                  |
| <kbd>Ctrl</kbd> + <kbd>F12</kbd>                                      | Go to implementations                                                         |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>F12</kbd>                   | Peek implementations                                                          |
| <kbd>Ctrl</kbd> + <kbd>PgUp</kbd>/<kbd>PgDown</kbd>                   | Navigate file history                                                         |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>PgUp</kbd>/<kbd>PgDown</kbd> | Go Forward/Back                                                               |
| <kbd></kbd>                                                           | Highlight usages in file; can use on return/throw                             |
| <kbd></kbd>                                                           | Hide/restore all windows                                                      |
| <kbd></kbd>                                                           | Open current file in new window                                               |
| <kbd>Ctrl</kbd> + <kbd>1</kbd>                                        | Focus editor                                                                  |
| <kbd>Alt</kbd> + <kbd>Num +</kbd>                                     | Increase editor                                                               |
| <kbd>Alt</kbd> + <kbd>Num -</kbd>                                     | Decrease editor                                                               |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>M</kbd>                     | Toggle Problems View                                                          |
| <kbd>Ctrl</kbd> + <kbd>K</kbd> <kbd>Ctrl</kbd> + <kbd>H</kbd>         | Toggle Output View                                                            |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Y</kbd>                     | Toggle Debug Console                                                          |
| <kbd>Ctrl</kbd> + <kbd>`</kbd>                                        | Toggle Terminal                                                               |

## Code bearbeiten

| Tastenkombination                                          | Beschreibung                                                                                                      |
|:---------------------------------------------------------- |:----------------------------------------------------------------------------------------------------------------- |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>[</kbd>          | Fold section                                                                                                      |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>]</kbd>          | Unfold section                                                                                                    |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>→</kbd>           | Expand section at caret, (expands via word essentially)                                                           |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>←</kbd>           | Reduces section at caret                                                                                          |
| <kbd></kbd>                                                | Complete current statement; adds semicolon, blocks, etc                                                           |
| <kbd>Alt</kbd> + <kbd>D</kbd>                              | Duplicate line                                                                                                    |
| <kbd></kbd>                                                | Clipboard history                                                                                                 |
| <kbd></kbd>                                                | Create new cursor                                                                                                 |
| <kbd>Ctrl</kbd> + <kbd>D</kbd>                             | Select next occurrence                                                                                            |
| <kbd>Ctrl</kbd> + <kbd>U</kbd>                             | Deselect                                                                                                          |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>L</kbd>          | Select all occurrences                                                                                            |
| <kbd></kbd>                                                | Move selection                                                                                                    |
| <kbd></kbd>                                                | Move statement                                                                                                    |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>I</kbd>          | Reformat code based on code style use                                                                             |
| <kbd>Ctrl</kbd> + <kbd>K</kbd> <kbd>I</kbd> + <kbd>F</kbd> | Reformat selected code based on code style use                                                                    |
| <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>O</kbd>           | Optimize Imports                                                                                                  |
| <kbd></kbd>                                                | Basic completion (text based) / 2x for static/contstants / <kbd>Tab</kbd> to overrite, <kbd>Enter</kbd> to insert |
| <kbd></kbd>                                                | Smart completion (context based), i.e. show things you can instantiate at a given time                            |
| <kbd></kbd>                                                | Intention popup                                                                                                   |
| <kbd></kbd>                                                | On type, can switch to superclass, will automatically select that after ??? times                                 |
| Postfix completion                                         | `foo.notnull` expands to a wrapped if, defaults include `null`, `notnull`, `throws`                               |

## Code generieren

| Tastenkombination                                             | Beschreibung                                                     |
|:------------------------------------------------------------- |:---------------------------------------------------------------- |
| <kbd></kbd>                                                   | Generators (toString, constructor, etc)                          |
| <kbd></kbd>                                                   | Generate toString                                                |
| <kbd></kbd>                                                   | Expand html                                                      |
| <kbd></kbd>                                                   | Creates 10 list elements                                         |
| <kbd>F8</kbd>                                                 | Go to next highlighted error                                     |
| <kbd>Shift</kbd> + <kbd>F8</kbd>                              | Go to previous highlighted error                                 |
| <kbd>Ctrl</kbd> + <kbd>K</kbd> <kbd>Ctrl</kbd> + <kbd>I</kbd> | Show error description                                           |
| <kbd></kbd>                                                   | Refactoring (surround with...)                                   |
| <kbd>Ctr</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd>              | Refactor menu; specialized refactoring is more context sensitive |
| <kbd></kbd>                                                   | `if(reader != null) { ... }` generators                          |
| <kbd></kbd>                                                   | Live templates (on expression)                                   |

## Verschiedenes

| Tastenkombination | Beschreibung                                                |
|:----------------- |:----------------------------------------------------------- |
| <kbd></kbd>       | Structural search and replace; holy god this is complicated |
| <kbd></kbd>       | Search for shortcut                                         |
| <kbd></kbd>       | Commit                                                      |
| <kbd></kbd>       | Push                                                        |
| <kbd></kbd>       | Quick switch keymap; can create quick lists                 |
| <kbd></kbd>       | Collapse/expand region                                      |
| <kbd></kbd>       | Collapse/expand whole file                                  |
| <kbd></kbd>       | Highlight all occurrences of symbol                         |
