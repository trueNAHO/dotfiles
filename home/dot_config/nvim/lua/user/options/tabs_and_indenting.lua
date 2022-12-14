-- tabstop. Number of spaces a <Tab> in the text stands for. (local to buffer)
vim.opt.ts = 4
-- shiftwidth. Number of spaces used for each step of (auto)indent. (local to
-- buffer)
vim.opt.sw = 4
-- vartabstop. List of number of spaces a tab counts for. (local to buffer)
--     set vts=
-- varsofttabstop. List of number of spaces a soft tabsstop counts for. (local
-- to buffer)
--     set vsts=
-- smarttab. A <Tab> in an indent inserts 'shiftwidth' spaces.
--     set sta    nosta
-- softtabstop. If non-zero, number of spaces to insert for a <Tab>. (local to
-- buffer)
vim.opt.sts = 4
-- shiftround. Round to 'shiftwidth' for "<<" and ">>".
--     set nosr    sr
-- expandtab. Expand <Tab> to spaces in Insert mode. (local to buffer)
vim.opt.et = true
-- autoindent. Automatically set the indent of a new line. (local to buffer)
--     set ai    noai
-- smartindent. Do clever autoindenting. (local to buffer)
vim.opt.si = true
-- cindent. Enable specific indenting for C code. (local to buffer)
--     set nocin    cin
-- cinoptions. Options for C-indenting. (local to buffer)
--     set cino=
-- cinkeys. Keys that trigger C-indenting in Insert mode. (local to buffer)
--     set cink=0{,0},0),0],:,0#,!^F,o,O,e
-- cinwords. List of words that cause more C-indent. (local to buffer)
--     set cinw=if,else,while,do,for,switch
-- cinscopedecls. List of scope declaration names used by cino-g. (local to
-- buffer)
--     set cinsd=public,protected,private
-- indentexpr. Expression used to obtain the indent of a line. (local to buffer)
--     set inde=GetVimIndent()
-- indentkeys. Keys that trigger indenting with 'indentexpr' in Insert mode.
-- (local to buffer)
--     set indk=0{,0},0),0],!^F,o,O,e,=endif,=enddef,=endfu,=endfor,=endwh,=endtry,=},=else,=cat,=finall,=END,0\\,0=\"\\\
-- copyindent. Copy whitespace for indenting from previous line. (local to
-- buffer)
--     set noci    ci
-- preserveindent. Preserve kind of whitespace when changing indent. (local to
-- buffer)
--     set nopi    pi
-- lisp. Enable lisp mode. (local to buffer)
--     set nolisp    lisp
-- lispwords. Words that change how lisp indenting works.
--     set lw=defun,define,defmacro,set!,lambda,if,case,let,flet,let*,letrec,do,do*,define-syntax,let-syntax,letrec-syntax,destructuring-bind,defpackage,defparameter,defstruct,deftype,defvar,do-all-symbols,do-external-symbols,do-symbols,dolist,dotimes,ecase,etypecase,eval-when,labels,macrolet,multiple-value-bind,multiple-value-call,multiple-value-prog1,multiple-value-setq,prog1,progv,typecase,unless,unwind-protect,when,with-input-from-string,with-open-file,with-open-stream,with-output-to-string,with-package-iterator,define-condition,handler-bind,handler-case,restart-bind,restart-case,with-simple-restart,store-value,use-value,muffle-warning,abort,continue,with-slots,with-slots*,with-accessors,with-accessors*,defclass,defmethod,print-unreadable-object
