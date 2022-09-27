-- foldenable. Unset to display all folds open. (local to window)
--     set fen    nofen
-- foldlevel. Folds with a level higher than this number will be closed. (local
-- to window)
--     set fdl=0
-- foldlevelstart. Value for 'foldlevel' when starting to edit a file.
--     set fdls=-1
-- foldcolumn. Width of the column used to indicate folds. (local to window)
--     set fdc=0
-- foldtext. Expression used to display the text of a closed fold. (local to
-- window)
--     set fdt=foldtext()
-- foldclose. Set to "all" to close a fold when the cursor leaves it.
--     set fcl=
-- foldopen. Specifies for which commands a fold will be opened.
--     set fdo=block,hor,mark,percent,quickfix,search,tag,undo
-- foldminlines. Minimum number of screen lines for a fold to be closed. (local
-- to window)
--     set fml=1
-- commentstring. Template for comments; used to put the marker in.
--     set cms=\"%s
-- foldmethod. Folding type: "manual", "indent", "expr", "marker",.
--     "syntax" or "diff" (local to window)
vim.opt.fdm = "marker"
-- foldexpr. Expression used when 'foldmethod' is "expr". (local to window)
--     set fde=0
-- foldignore. Used to ignore lines when 'foldmethod' is "indent". (local to
-- window)
--     set fdi=#
-- foldmarker. Markers used when 'foldmethod' is "marker". (local to window)
--     set fmr={{{,}}}
-- foldnestmax. Maximum fold depth for when 'foldmethod' is "indent" or
-- "syntax". (local to window)
--     set fdn=20
