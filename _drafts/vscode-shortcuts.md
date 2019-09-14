---
title: VSCode Shortcuts
tags: [liste, vscode]
---

<!-- https://github.com/kasecato/vscode-intellij-idea-keybindings -->

<!-- https://github.com/isudox/vscode-jetbrains-keybindings/blob/master/package.json -->

## Navigation

| Tastenkombination                                                        | Beschreibung                                                              |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------- |
| <kbd>Crtl</kbd> + <kbd>T</kbd>                                           | Go to Symbol                                                              |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd>                        | Project structure (folders), can use keyboard to navigate or find by word |
| <kbd>Crtl</kbd> + <kbd>Shift</kbd> + <kbd>F</kbd>                        | Search everywhere                                                         |
| <kbd>Crtl</kbd> + <kbd>Shift</kbd> + <kbd>.</kbd>                        | Project structure popup / Breadcrumbs, navigate with ctrl + arrows        |
| <kbd>Crtl</kbd> + <kbd>Shift</kbd> + <kbd>O</kbd>                        | Symbols current file.  Type `:` to sort                                   |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>↓</kbd>/<kbd>↑</kbd>            | Go to next/previous symbol (extension)                                    |
| <kbd>Crtl</kbd> + <kbd>E</kbd>                                           | Recent files                                                              |
| <kbd>Crtl</kbd> + <kbd>K</kbd> <kbd>Crtl</kbd> + <kbd>Q</kbd>            | Jump to last edited file                                                  |
| <kbd>Crtl</kbd> + <kbd>Tab</kbd>                                         | Switch between open editors                                               |
| <kbd>F12</kbd>                                                           | Go to definition                                                          |
| <kbd>Alt</kbd> + <kbd>F12</kbd>                                          | Go to declaration                                                         |
| <kbd>Shift</kbd> + <kbd>F12</kbd>                                        | Peek References                                                           |
| <kbd></kbd>                                                              | Parameter info                                                            |
| <kbd>Ctrl</kbd> + <kbd>K</kbd> <kbd>Ctrl</kbd> + <kbd>I</kbd>            | Quickdocumentation                                                        |
| <kbd></kbd>                                                              | Super definition/decleration                                              |
| <kbd>Ctrl</kbd> + <kbd>F12</kbd>                                         | Go to implementations                                                     |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>F12</kbd>                      | Peek implementations                                                      |
| <kbd>Ctrl</kbd> + <kbd>PgUp</kbd>/<kbd>PgDown</kbd>                      | Navigate file history                                                     |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>PgUp</kbd>/<kbd>PgDown</kbd>    | Go Forward/Back                                                           |
| <kbd></kbd>                                                              | Highlight usages in file; can use on return/throw                         |
| <kbd>Ctrl</kbd> + <kbd>K</kbd> <kbd>O</kbd>                              | Open current file in new window                                           |
| <kbd>Ctrl</kbd> + <kbd>1</kbd>...<kbd>0</kbd>                            | Focus editor (Group 1..0                                                  |
| <kbd>Alt</kbd> + <kbd>Num +</kbd>                                        | Increase editor/terminal                                                  |
| <kbd>Alt</kbd> + <kbd>Num -</kbd>                                        | Decrease editor/terminal                                                  |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>M</kbd>                        | Toggle Problems View                                                      |
| <kbd>Ctrl</kbd> + <kbd>K</kbd> <kbd>Ctrl</kbd> + <kbd>H</kbd>            | Toggle Output View                                                        |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Y</kbd>                        | Toggle Debug Console                                                      |
| <kbd>Ctrl</kbd> + <kbd>`</kbd>                                           | Toggle Terminal                                                           |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>`</kbd>                        | Create new Terminal                                                       |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>←</kbd>/<kbd>→</kbd>             | Move Editor to the next/previous Group                                    |
| <kbd>Ctrl</kbd> + <kbd>K</kbd> <kbd>Ctrl</kbd> <kbd>←</kbd>/<kbd>→</kbd> | Focus left/right editor Group                                             |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>j</kbd>/<kbd>k</kbd>           | Focus previous/next terminal                                              |
| <kbd>Ctrl</kbd> + <kbd>/</kbd>                                           | Split terminal                                                            |
| <kbd>Alt</kbd> + <kbd>←</kbd>/<kbd>→</kbd>                               | Focus previous/next terminal pane                                         |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>↓</kbd>/<kbd>↑</kbd>            | Scroll Terminal up/down                                                   |
| <kbd>Shift</kbd> + <kbd>PgUp</kbd>/<kbd>PgDn</kbd>                       | Scroll Terminal page up/down                                              |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>+</kbd>                         | Toggle maximize Terminal, when focused                                    |

## Code bearbeiten

| Tastenkombination                                              | Beschreibung                                            |
| -------------------------------------------------------------- | ------------------------------------------------------- |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>[</kbd>              | Fold section                                            |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>]</kbd>              | Unfold section                                          |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>→</kbd>               | Expand section at caret, (expands via word essentially) |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>←</kbd>               | Reduces section at caret                                |
| <kbd>Alt</kbd> + <kbd>D</kbd>                                  | Duplicate line                                          |
| <kbd></kbd>                                                    | Clipboard history                                       |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>↓</kbd>/<kbd>↑</kbd> | Create new cursor above/under                           |
| <kbd>Ctrl</kbd> + <kbd>D</kbd>                                 | Select next occurrence                                  |
| <kbd>Ctrl</kbd> + <kbd>U</kbd>                                 | Deselect                                                |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>L</kbd>              | Select all occurrences                                  |
| <kbd>Alt</kbd> + <kbd>↓</kbd>/<kbd>↑</kbd>                     | Move current row down/up                                |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>I</kbd>              | Reformat code based on code style use                   |
| <kbd>Ctrl</kbd> + <kbd>K</kbd> <kbd>I</kbd> + <kbd>F</kbd>     | Reformat selected code based on code style use          |
| <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>O</kbd>               | Optimize Imports                                        |
| <kbd>Ctrl</kbd> + <kbd>Space</kbd>                             | Basic completion                                        |
| <kbd>Ctrl</kbd> + <kbd>.</kbd>                                 | Intention popup                                         |

## Code generieren

| Tastenkombination                                             | Beschreibung                                                     |
| ------------------------------------------------------------- | ---------------------------------------------------------------- |
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

| Tastenkombination                                 | Beschreibung        |
| ------------------------------------------------- | ------------------- |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> | Search for shortcut |
| <kbd></kbd>                                       | Commit              |
| <kbd></kbd>                                       | Push                |
