# code comment color

**Reference: Demo**
https://stackoverflow.com/questions/45195023/how-do-i-change-color-of-comments-in-visual-studio-code

**Reference: How To Open Scope-Inspector**
https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide#scope-inspector

1.     - string.other.link.title
2.     comment

# configure build-in color pick

@note use json-schemas https://json-schema.org/learn/
@demo https://json-schema.org/learn/examples/card.schema.json

# close markdown preview

直接用 VS Code 打开：

1. 按 `Ctrl + Shift + P`

2. 输入：

   ```
   Preferences: Open User Settings (JSON)
   ```

搜索 `workbench.editorAssociations`

`"*.md"`改为`"*.md": "default"`