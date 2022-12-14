-- printoptions. List of items that control the format of :hardcopy output.
--     set popt=
-- printdevice. Name of the printer to be used for :hardcopy.
--     set pdev=
-- printexpr. Expression used to print the PostScript file for :hardcopy.
--     set pexpr=system(['lpr']\ +\ (empty(&printdevice)?[]:['-P',\ &printdevice])\ +\ [v:fname_in]).\ delete(v:fname_in)+\ v:shell_error
-- printfont. Name of the font to be used for :hardcopy.
--     set pfn=courier
-- printheader. Format of the header used for :hardcopy.
--     set pheader=%<%f%h%m%=Page\ %N
-- printencoding. Encoding used to print the PostScript file for :hardcopy.
--     set penc=
-- printmbcharset. The CJK character set to be used for CJK output from
-- :hardcopy.
--     set pmbcs=
-- printmbfont. List of font names to be used for CJK output from :hardcopy.
--     set pmbfn=
