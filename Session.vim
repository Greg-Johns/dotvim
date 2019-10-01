let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +590 init.vim
argglobal
%argdel
edit init.vim
set splitbelow splitright
set nosplitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=10
setlocal fen
25
normal! zo
42
normal! zo
44
normal! zo
45
normal! zo
48
normal! zo
62
normal! zo
122
normal! zo
123
normal! zo
122
normal! zc
139
normal! zo
152
normal! zo
162
normal! zo
164
normal! zo
165
normal! zo
165
normal! zo
165
normal! zo
164
normal! zc
171
normal! zo
177
normal! zo
179
normal! zo
181
normal! zo
186
normal! zo
191
normal! zo
191
normal! zo
195
normal! zo
195
normal! zo
202
normal! zo
202
normal! zo
209
normal! zo
210
normal! zo
215
normal! zo
217
normal! zo
219
normal! zo
223
normal! zo
224
normal! zo
175
normal! zo
175
normal! zo
177
normal! zo
179
normal! zo
181
normal! zo
186
normal! zo
191
normal! zo
191
normal! zo
191
normal! zo
195
normal! zo
195
normal! zo
195
normal! zo
202
normal! zo
202
normal! zo
202
normal! zo
209
normal! zo
210
normal! zo
215
normal! zo
217
normal! zo
219
normal! zo
223
normal! zo
224
normal! zo
359
normal! zo
360
normal! zo
360
normal! zo
360
normal! zc
397
normal! zo
430
normal! zo
447
normal! zo
575
normal! zo
603
normal! zo
605
normal! zo
611
normal! zo
603
normal! zc
621
normal! zo
622
normal! zo
621
normal! zc
632
normal! zo
633
normal! zo
632
normal! zc
575
normal! zc
let s:l = 539 - ((13 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
539
normal! 0
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOFc
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
