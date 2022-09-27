-- undolevels. Maximum number of changes that can be undone. (global or local
-- to buffer)
--     set ul=1000
-- undofile. Automatically save and restore undo history.
vim.opt.udf = true
-- undodir. List of directories for undo files.
--     set udir=/home/noah/.local/share/nvim/undo//
-- undoreload. Maximum number lines to save for undo on a buffer reload.
--     set ur=10000
-- modified. Changes have been made and not written to a file. (local to buffer)
--     set mod    nomod
-- readonly. Buffer is not to be written. (local to buffer)
--     set noro    ro
-- modifiable. Changes to the text are possible. (local to buffer)
--     set ma    noma
-- textwidth. Line length above which to break a line. (local to buffer)
--     set tw=78
-- wrapmargin. Margin from the right in which to break a line. (local to buffer)
--     set wm=0
-- backspace. Specifies what <BS>, CTRL-W, etc. can do in Insert mode.
--     set bs=indent,eol,start
-- comments. Definition of what comment lines look like. (local to buffer)
--     set com=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"
-- formatoptions. List of flags that tell how automatic formatting works.
-- (local to buffer)
--     set fo=jcroql
-- formatlistpat. Pattern to recognize a numbered list. (local to buffer)
--     set flp=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
-- formatexpr. Expression used for "gq" to format lines. (local to buffer)
--     set fex=
-- complete. Specifies how Insert mode completion works for CTRL-N and CTRL-P.
-- (local to buffer)
--     set cpt=.,w,b,u,t
-- completeopt. Whether to use a popup menu for Insert mode completion.
--     set cot=menu,preview
-- pumheight. Maximum height of the popup menu.
--     set ph=0
-- pumwidth. Minimum width of the popup menu.
--     set pw=15
-- completefunc. User defined function for Insert mode completion. (local to
-- buffer)
--     set cfu=
-- omnifunc. Function for filetype-specific Insert mode completion. (local to
-- buffer)
--     set ofu=
-- dictionary. List of dictionary files for keyword completion. (global or
-- local to buffer)
--     set dict=
-- thesaurus. List of thesaurus files for keyword completion. (global or local
-- to buffer)
--     set tsr=
-- infercase. Adjust case of a keyword completion match. (local to buffer)
--     set noinf    inf
-- digraph. Enable entering digraphs with c1 <BS> c2.
--     set nodg    dg
-- tildeop. The "~" command behaves like an operator.
--     set notop    top
-- operatorfunc. Function called for the "g@" operator.
--     set opfunc=
-- showmatch. When inserting a bracket, briefly jump to its match.
--     set nosm    sm
-- matchtime. Tenth of a second to show a match for 'showmatch'.
--     set mat=5
-- matchpairs. List of pairs that match for the "%" command. (local to buffer)
--     set mps=(:),{:},[:]
-- joinspaces. Use two spaces after '.' when joining a line.
--     set nojs    js
-- nrformats. "alpha", "octal", "hex", "bin" and/or "unsigned"; number formats.
-- recognized for CTRL-A and CTRL-X commands (local to buffer)
--     set nf=bin,hex
