-- undolevels	maximum number of changes that can be undone
-- 	(global or local to buffer)
--  	set ul=1000
-- undofile	automatically save and restore undo history
--  	set noudf	udf
-- undodir	list of directories for undo files
--  	set udir=/home/noah/.local/share/nvim/undo//
-- undoreload	maximum number lines to save for undo on a buffer reload
--  	set ur=10000
-- modified	changes have been made and not written to a file
-- 	(local to buffer)
--  	set mod	nomod
-- readonly	buffer is not to be written
-- 	(local to buffer)
--  	set noro	ro
-- modifiable	changes to the text are possible
-- 	(local to buffer)
--  	set ma	noma
-- textwidth	line length above which to break a line
-- 	(local to buffer)
--  	set tw=78
-- wrapmargin	margin from the right in which to break a line
-- 	(local to buffer)
--  	set wm=0
-- backspace	specifies what <BS>, CTRL-W, etc. can do in Insert mode
--  	set bs=indent,eol,start
-- comments	definition of what comment lines look like
-- 	(local to buffer)
--  	set com=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"
-- formatoptions	list of flags that tell how automatic formatting works
-- 	(local to buffer)
--  	set fo=jcroql
-- formatlistpat	pattern to recognize a numbered list
-- 	(local to buffer)
--  	set flp=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
-- formatexpr	expression used for "gq" to format lines
-- 	(local to buffer)
--  	set fex=
-- complete	specifies how Insert mode completion works for CTRL-N and CTRL-P
-- 	(local to buffer)
--  	set cpt=.,w,b,u,t
-- completeopt	whether to use a popup menu for Insert mode completion
--  	set cot=menu,preview
-- pumheight	maximum height of the popup menu
--  	set ph=0
-- pumwidth	minimum width of the popup menu
--  	set pw=15
-- completefunc	user defined function for Insert mode completion
-- 	(local to buffer)
--  	set cfu=
-- omnifunc	function for filetype-specific Insert mode completion
-- 	(local to buffer)
--  	set ofu=
-- dictionary	list of dictionary files for keyword completion
-- 	(global or local to buffer)
--  	set dict=
-- thesaurus	list of thesaurus files for keyword completion
-- 	(global or local to buffer)
--  	set tsr=
-- infercase	adjust case of a keyword completion match
-- 	(local to buffer)
--  	set noinf	inf
-- digraph	enable entering digraphs with c1 <BS> c2
--  	set nodg	dg
-- tildeop	the "~" command behaves like an operator
--  	set notop	top
-- operatorfunc	function called for the "g@" operator
--  	set opfunc=
-- showmatch	when inserting a bracket, briefly jump to its match
--  	set nosm	sm
-- matchtime	tenth of a second to show a match for 'showmatch'
--  	set mat=5
-- matchpairs	list of pairs that match for the "%" command
-- 	(local to buffer)
--  	set mps=(:),{:},[:]
-- joinspaces	use two spaces after '.' when joining a line
--  	set nojs	js
-- nrformats	"alpha", "octal", "hex", "bin" and/or "unsigned"; number formats
-- 	recognized for CTRL-A and CTRL-X commands
-- 	(local to buffer)
--  	set nf=bin,hex
