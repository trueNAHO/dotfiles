-- modeline. Enable using settings from modelines when reading a file. (local
-- to buffer)
--     set ml    noml
-- modelineexpr. Allow setting expression options from a modeline.
--     set nomle    mle
-- modelines. Number of lines to check for modelines.
--     set mls=5
-- binary. Binary file editing. (local to buffer)
--     set nobin    bin
-- endofline. Last line in the file has an end-of-line. (local to buffer)
--     set eol    noeol
-- fixendofline. Fixes missing end-of-line at end of text file. (local to
-- buffer)
--     set fixeol    nofixeol
-- bomb. Prepend a Byte Order Mark to the file. (local to buffer)
--     set nobomb    bomb
-- fileformat. End-of-line format: "dos", "unix" or "mac". (local to buffer)
--     set ff=unix
-- fileformats. List of file formats to look for when editing a file.
--     set ffs=unix,dos (local to buffer)
-- write. Writing files is allowed.
--     set write    nowrite
-- writebackup. Write a backup file before overwriting a file.
--     set wb    nowb
-- backup. Keep a backup after overwriting a file.
--     set nobk    bk
-- backupskip. Patterns that specify for which files a backup is not made.
--     set bsk=/tmp/*
-- backupcopy. Whether to make the backup as a copy or rename the existing
-- file. (global or local to buffer)
--     set bkc=auto
-- backupdir. List of directories to put backup files in.
--     set bdir=.,/home/noah/.local/share/nvim/backup//
-- backupext. File name extension for the backup file.
--     set bex=~
-- autowrite. Automatically write a file when leaving a modified buffer.
--     set noaw    aw
-- autowriteall. As 'autowrite', but works with more commands.
--     set noawa    awa
-- writeany. Always write without asking for confirmation.
--     set nowa    wa
-- autoread. Automatically read a file when it was modified outside of Vim.
-- (global or local to buffer)
--     set ar    noar
-- patchmode. Keep oldest version of a file; specifies file name extension.
--     set pm=
-- fsync. Forcibly sync the file to disk after writing it.
--     set nofs    fs
