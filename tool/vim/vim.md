
**Reference**  
[./vimboot-OPL.pdf](vimbook-OPL.pdf): http://www.truth.sk/vim/vimbook-OPL.pdf

# Basic Editing 
|desc|type|
|:-:|:-:|
|Inserting Text| `i` |
|Delete Character| `x` |
|Delete Line|`dd`|
|Delete n word|`d`n`w`<br />`d3w` means delete 3 words|
|Undo| `u` |
|Redo| `r` |
|Insert the End of a Line|`a`|
|Opening Up New Line|`o`|
|Get Help|`:help / F1`|

> Get Help AND EXIT : F1 then :q!

> Using a Count to Edit Faster
use the command 3a!<Esc>, then you could see that vim typed !!! in the text

# Editing a Little Faster

|desc|type|
|:-:|:-:|
|forward word|n`w`|
|backward word|n`b`<sup><br /> `4b`  moves back four words</sup>|
|jump line|n`j`|
|backward line|n`k`|
|Moving to the Line End|n`$`|
|Moving to the Start|`gg`|
|Moving to a Specific Line|n`G`<br />**Attention: Capital G**|
|Telling Where You Are in a File|`:set number`|
|Hide Line Number|`:set nonumber`|
|Scrolling Up|`Ctrl + U`|
|Scrolling Down|`Ctrl + D`|


> Tip: show number permently
> MAC: 
> `echo 'syntax on \n set nu!' >> ~/.vimrc`
> Linux:  
> `echo '：set number'  >> ~/.vimrc`

> MAC: ctrl -> control

# Advance
## Character Encoding
```
echo 'set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936'  >> ~/.vimrc
echo 'set termencoding=utf-8'  >> ~/.vimrc
echo 'set encoding=utf-8'  >> ~/.vimrc
```

https://linuxize.com/post/how-to-copy-cut-paste-in-vim/