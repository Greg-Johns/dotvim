let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Projects/BostonSports
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +480 ~/.config/nvim/init.vim
argglobal
%argdel
edit ~/.config/nvim/init.vim
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 20 + 22) / 44)
exe '2resize ' . ((&lines * 21 + 22) / 44)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=10
setlocal fen
9
normal! zo
25
normal! zo
42
normal! zo
49
normal! zo
109
normal! zo
110
normal! zo
126
normal! zo
139
normal! zo
143
normal! zo
143
normal! zo
149
normal! zo
149
normal! zo
160
normal! zo
162
normal! zo
163
normal! zo
163
normal! zo
163
normal! zo
162
normal! zc
169
normal! zo
173
normal! zo
175
normal! zo
177
normal! zo
179
normal! zo
184
normal! zo
189
normal! zo
189
normal! zo
189
normal! zo
193
normal! zo
193
normal! zo
200
normal! zo
200
normal! zo
207
normal! zo
208
normal! zo
213
normal! zo
215
normal! zo
217
normal! zo
221
normal! zo
222
normal! zo
249
normal! zo
267
normal! zo
338
normal! zo
343
normal! zo
357
normal! zo
358
normal! zo
358
normal! zo
364
normal! zo
395
normal! zo
428
normal! zo
434
normal! zo
435
normal! zo
445
normal! zo
483
normal! zo
560
normal! zo
570
normal! zo
571
normal! zo
571
normal! zo
571
normal! zo
571
normal! zo
571
normal! zo
571
normal! zo
571
normal! zo
571
normal! zo
571
normal! zo
578
normal! zo
583
normal! zo
600
normal! zo
611
normal! zo
613
normal! zo
619
normal! zo
629
normal! zo
630
normal! zo
629
normal! zc
640
normal! zo
641
normal! zo
640
normal! zc
let s:l = 52 - ((18 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
52
normal! 0
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists("~/.config/nvim/init.vim") | buffer ~/.config/nvim/init.vim | else | edit ~/.config/nvim/init.vim | endif
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=10
setlocal fen
9
normal! zo
25
normal! zo
42
normal! zo
49
normal! zo
109
normal! zo
110
normal! zo
126
normal! zo
139
normal! zo
143
normal! zo
143
normal! zo
149
normal! zo
149
normal! zo
160
normal! zo
162
normal! zo
163
normal! zo
163
normal! zo
163
normal! zo
162
normal! zc
169
normal! zo
173
normal! zo
175
normal! zo
177
normal! zo
179
normal! zo
184
normal! zo
189
normal! zo
189
normal! zo
189
normal! zo
193
normal! zo
193
normal! zo
200
normal! zo
200
normal! zo
207
normal! zo
208
normal! zo
213
normal! zo
215
normal! zo
217
normal! zo
221
normal! zo
222
normal! zo
249
normal! zo
267
normal! zo
338
normal! zo
343
normal! zo
357
normal! zo
358
normal! zo
358
normal! zo
364
normal! zo
384
normal! zo
395
normal! zo
428
normal! zo
434
normal! zo
435
normal! zo
445
normal! zo
483
normal! zo
560
normal! zo
570
normal! zo
571
normal! zo
571
normal! zo
571
normal! zo
571
normal! zo
571
normal! zo
571
normal! zo
571
normal! zo
571
normal! zo
571
normal! zo
578
normal! zo
583
normal! zo
600
normal! zo
611
normal! zo
613
normal! zo
619
normal! zo
629
normal! zo
630
normal! zo
629
normal! zc
640
normal! zo
641
normal! zo
640
normal! zc
let s:l = 549 - ((19 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
549
normal! 0
lcd ~/.config/nvim
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 20 + 22) / 44)
exe '2resize ' . ((&lines * 21 + 22) / 44)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOFcI
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
