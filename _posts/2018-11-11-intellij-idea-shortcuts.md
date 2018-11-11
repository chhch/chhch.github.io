---
title: Intellij IDEA Shortcuts
tags: [liste, intellij-idea]
---

## Navigation

| Tastenkombination                                                  | Beschreibung                                                                  |
| :----------------------------------------------------------------- | :---------------------------------------------------------------------------- |
| <kbd>Ctrl</kbd> + <kbd>N</kbd>                                     | Go to class; by first letter, i.e. `BF` for `BarFactory`; to line `BF:40`     |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>N</kbd>                  | Go to class, toggle by project files; can go to folder by doing `/baz_folder` |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>N</kbd> | Any symbol; can filter by nameSpace, i.e. `FBF.getFoo`                        |
| <kbd>Alt</kbd> + <kbd>1</kbd>                                      | Project structure (folders), can use keyboard to navigate or find by word     |
| (Double-press) <kbd>Shift</kbd>                                    | Search everywhere                                                             |
| <kbd>Alt</kbd> + <kbd>7</kbd>                                      | Project structure sidebar (symbol based)                                      |
| <kbd>Ctrl</kbd> + <kbd>F12</kbd>                                   | Project structure popup                                                       |
| <kbd>Ctrl</kbd> + <kbd>E</kbd>                                     | Recent files                                                                  |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd>                  | Recently edited files                                                         |
| <kbd>Ctrl</kbd> + <kbd>Tab</kbd>                                   | Quick switch                                                                  |
| <kbd>Alt</kbd> + <kbd>Home</kbd>                                   | Jump to navigation bar; navigate with keys                                    |
| <kbd>Ctrl</kbd> + <kbd>B</kbd>                                     | Go to definition                                                              |
| <kbd>F4</kbd>                                                      | Go to source/definition                                                       |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>I</kbd>                  | Quick definition popup                                                        |
| <kbd>Ctrl</kbd> + <kbd>P</kbd>                                     | Parameter info                                                                |
| <kbd>Ctrl</kbd> + <kbd>Q</kbd>                                     | Quickdocumentation                                                            |
| <kbd>Ctrl</kbd> + <kbd>U</kbd>                                     | Super definition/decleration                                                  |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>B</kbd>                    | Go to implementations                                                         |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>←</kbd> / <kbd>→</kbd>     | Navigate file history                                                         |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>F7</kbd>                 | Highlight usages in file; can use on return/throw                             |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>F12</kbd>                | Hide/restore all windows                                                      |
| <kbd>Shift</kbd> + <kbd>F4</kbd>                                   | Open current file in new window                                               |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>←</kbd> / <kbd>→</kbd>   | Resize window you’re in                                                       |

## Code bearbeiten

| Tastenkombination                                                                                        | Beschreibung                                                                                                      |
| :------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------- |
| <kbd>Ctrl</kbd> + <kbd>.</kbd>                                                                           | Fold section                                                                                                      |
| <kbd>Ctrl</kbd> + <kbd>W</kbd>                                                                           | Expand section at caret, (expands via word essentially)                                                           |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>W</kbd>                                                        | Reduces section at caret                                                                                          |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Enter</kbd>                                                    | Complete current statement; adds semicolon, blocks, etc                                                           |
| <kbd>Ctrl</kbd> + <kbd>D</kbd>                                                                           | Duplicate                                                                                                         |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>V</kbd>                                                        | Clipboard history                                                                                                 |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + (Click) / (Double Click) <kbd>Ctrl</kbd> <kbd>↑</kbd> / <kbd>↓</kbd> | Create new cursor                                                                                                 |
| <kbd>Alt</kbd> + <kbd>J</kbd>                                                                            | Select next occurrence                                                                                            |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>J</kbd>                                                         | Deselect                                                                                                          |
| <kbd>Alt</kbd> + <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>J</kbd>                                       | Select all occurrences                                                                                            |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>↑</kbd> / <kbd>↓</kbd>                                          | Move selection                                                                                                    |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>↑</kbd> / <kbd>↓</kbd>                                         | Move statement                                                                                                    |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>L</kbd>                                                          | Reformat code based on code style use                                                                             |
| <kbd>Ctrl</kbd> + <kbd>Space</kbd>                                                                       | Basic completion (text based) / 2x for static/contstants / <kbd>Tab</kbd> to overrite, <kbd>Enter</kbd> to insert |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Space</kbd>                                                    | Smart completion (context based), i.e. show things you can instantiate at a given time                            |
| <kbd>Alt</kbd> + <kbd>Enter</kbd>                                                                        | Intention popup                                                                                                   |
| <kbd>Shift</kbd> + <kbd>Tab</kbd>                                                                        | On type, can switch to superclass, will automatically select that after ??? times                                 |
| Postfix completion                                                                                       | `foo.notnull` expands to a wrapped if, defaults include `null`, `notnull`, `throws`                               |

## Code generieren

| Tastenkombination                                                  | Beschreibung                                                     |
| :----------------------------------------------------------------- | :--------------------------------------------------------------- |
| <kbd>Alt</kbd> + <kbd>N</kbd>                                      | Generators (toString, constructor, etc)                          |
| `toString` + <kbd>Tab</kbd>                                        | Generate toString                                                |
| `Table#something`                                                  | Expand html                                                      |
| `ul>li\*10`                                                        | Creates 10 list elements                                         |
| <kbd>F2</kbd> / <kbd>Shift</kbd> + <kbd>F2</kbd>                   | Go to next highlighted error                                     |
| <kbd>Ctrl</kbd> + <kbd>F1</kbd>                                    | Show error description                                           |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd>                    | Refactoring (surround with...)                                   |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd> | Refactor menu; specialized refactoring is more context sensitive |
| `reader.notNull()`                                                 | `if(reader != null) { ... }` generators                          |
| <kbd>Ctrl</kbd> + <kbd>J</kbd>                                     | Live templates (on expression)                                   |

## Verschiedenes

| Tastenkombination                                                | Beschreibung                                                |
| :--------------------------------------------------------------- | :---------------------------------------------------------- |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd>                | Structural search and replace; holy god this is complicated |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>A</kbd>                | Search for shortcut                                         |
| <kbd>Ctrl</kbd> + <kbd>K</kbd>                                   | Commit                                                      |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>K</kbd>                | Push                                                        |
| <kbd>Ctrl</kbd> + <kbd>`</kbd>                                   | Quick switch keymap; can create quick lists                 |
| <kbd>Ctrl</kbd> + <kbd>-</kbd> / <kbd>=</kbd>                    | Collapse/expand region                                      |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>-</kbd> / <kbd>=</kbd> | Collapse/expand whole file                                  |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>F7</kbd>               | Highlight all occurrences of symbol                         |

* * *

Referenz

-   [IntelliJ IDEA - 42 tips and tricks in 45 minutes (transcription)](https://www.reddit.com/r/programming/comments/36zj6q/intellij_idea_42_tips_and_tricks_in_45_minutes/crj521k)
