.model small 
.stack 200h
.data
starting_minutes dw 0
starting_secs db 0
prompt_time db 'Time: $'
temporary db ':$'
heading1 db '$'
heading2 db '$' 
heading3 db '$'
start_game db '                                  1. Xombie Rush$'
highscore db '                                  2. Xombie Shooter$'
exit_game db '                                  3. Exit$'
exit_prompt1 db '                    /``` /``\ |\/| |``   /``\ |  | |`` |``\$'
exit_prompt2 db '                    | __ |__| |  | |--   |  | |  | |-- |--/$'
exit_prompt3 db '                    \__/ |  | |  | |__   \__/  \/  |__ |  \$'
wall_y db '|                                                                              |$'                                                                                                 |$'
player db 'X$'
player_x db 39
player_y db 12
bullet db 'o$'
bullet_x db ?
bullet_y db ?
space db ' $'
enemy1 db '1$'
enemy1_x db 39
enemy1_y db 1
enemy2 db '2$'
enemy2_x db 39
enemy2_y db 22
enemy3 db '3$'
enemy3_x db 1
enemy3_y db 7
enemy4_x db 77
enemy4_y db 1
enemy4 db '4$'
enemy5 db '5$'
enemy5_x db 1 
enemy5_y db 9
enemy6 db '6$'
enemy6_x db 78 
enemy6_y db 11
enemy7_x db 18
enemy7_y db 1
enemy7 db '7$'
enemy8 db '8$'
enemy8_x db 44
enemy8_y db 22
enemy9_x db 1
enemy9_y db 3
enemy9 db '9$'
enemyA db 'A$'
enemyA_x db 77
enemyA_y db 18
enemyB_x db 60
enemyB_y db 1
enemyB db 'B$'
enemyC db 'C$'
enemyC_y db 22
enemyC_x db 30
enemyD db 'D$'
enemyE db 'E$'
enemyD_x db 3
enemyD_y db 1
enemyE_x db 69
enemyE_y db 22
enemyF db 'F$'
enemyF_x db 2
enemyF_y db 1
enemyG db 'G$'
enemyG_x db 70
enemyG_y db 22
life db '^$'
life_x db 50
life_y db 1
score dw 0
score_prompt db 'SCORE: $'
score_x db 43
score_y db 0
lives dw 3
lives_prompt db 'LIVES: $'
.code
main proc
mov ax, @data
mov ds, ax
mov ah, 00        ;CLEARING THE SCREEN
mov al, 02
int 10h 
lea dx, heading1
mov ah, 09h
int 21h
mov dl, 10        ;PRINTING NEW LINE
mov ah, 02h
int 21h 
lea dx, heading2
mov ah, 09h
int 21h
mov dl, 10        
mov ah, 02h
int 21h
lea dx, heading3
mov ah, 09h
int 21h
mov dl, 10
mov ah, 02h
int 21h
int 21h
lea dx, start_game
mov ah, 09h
int 21h 
mov dl, 10
mov ah, 02h
int 21h
lea dx, highscore
mov ah, 09h
int 21h
mov dl, 10
mov ah, 02h
int 21h
lea dx, exit_game
mov ah, 09h
int 21h
mov dl, 78
mov dh, 24
mov bh, 0
mov ah, 02h
int 10h
mov ah, 00h
int 16h
cmp al, '1'
je begin1
cmp al, '2'
je begin2
jmp exit
begin1:               ;START
mov ax, 0002         ;CLEARING SCREEN
int 10h
call get_random_enemy1
call compare_enemy1
call clear_keyboard_buffer
call wall 
call print_score_prompt 	
call print_score
call print_lives_prompt
call print_lives
call DrawPlayer
call move_enemy1
jmp exit
begin2:
mov ah, 2ch
int 21h
mov starting_minutes, cl
mov starting_secs, dh
mov ax, 0002         ;CLEARING SCREEN
int 10h
call get_random_enemy1
game_sequence:;SEQUENCE OF GAME
cmp score, 50
je exit_temp
call compare_enemy1
call compare_enemy2
call compare_enemy3
call compare_enemy6
call clear_keyboard_buffer
call wall 
call print_score_prompt 	
call print_score
call DrawPlayer
call draw_enemy1
call draw_enemy3
call draw_enemy6
call draw_enemy2
mov ah, 00h
int 16h
cmp al, 'x'
je exit_temp

cmp al, 'd'
je moveright

cmp al, 'w'
je moveup

cmp al, 's'
je movedown

cmp al, 'a'
je moveleft

cmp al, 'l'
je bulletright

cmp al, 'k'
je temp_bulletdown

cmp al, 'j'
je temp_bulletleft

cmp al, 'i'
je temp_bulletup

jmp game_sequence

moveright:
cmp player_x, 78
je game_sequence
call update_player
inc player_x
call DrawPlayer
call clear_keyboard_buffer
jmp game_sequence

temp_game_sequence:
jmp game_sequence

exit_temp:
jmp exit

temp_bulletleft:
jmp bulletleft

moveup:
cmp player_y, 1
je temp_game_sequence
call update_player
dec player_y
call DrawPlayer
call clear_keyboard_buffer
jmp game_sequence

movedown:
cmp player_y, 22
je temp_game_sequence
call update_player
inc player_y
call DrawPlayer
call clear_keyboard_buffer
jmp game_sequence

temp_bulletdown:
jmp bulletdown

moveleft:
cmp player_x, 1
je temp_game_sequence
call update_player
dec player_x
call DrawPlayer
call clear_keyboard_buffer
jmp game_sequence

temp_bulletup:
jmp bulletup

temp1_game_sequence:
jmp temp_game_sequence

bulletright:
mov bl, player_x
mov bullet_x, bl
mov bl, player_y
mov bullet_y, bl
cmp bullet_x, 78
je temp1_game_sequence
inc bullet_x
call DrawBullet
cmp bullet_x, 78
je temp1_game_sequence
right:
call compare_enemy1
call compare_enemy2
call compare_enemy3
call compare_enemy6
mov ah, 01h
int 16h
jnz button_pressed_r
mov ah, 86h
mov dx, 10000
int 15h
call DrawBullet
call UpdateBullet
inc bullet_x
call DrawBullet
cmp bullet_x, 78
je temp1_game_sequence
jmp right
button_pressed_r:
cmp al, 'd'
je moveright_r
cmp al, 'w'
je moveup_r
cmp al, 's'
je movedown_r
cmp al, 'a'
je moveleft_r
call clear_keyboard_buffer
jmp right

moveleft_r:
cmp player_x, 1
je temp_right
call Update_Player
dec player_x
call DrawPlayer
call clear_keyboard_buffer
jmp right

temp4_game_sequence:
jmp game_sequence

movedown_r:
cmp player_y, 22
je temp_right
call Update_Player
inc player_y
call DrawPlayer
call clear_keyboard_buffer
jmp right

temp_right:
call clear_keyboard_buffer
jmp right

moveup_r:
cmp player_y, 1
je temp_right
call Update_Player
dec player_y
call DrawPlayer
call clear_keyboard_buffer
jmp right

moveright_r:
cmp player_x, 78
je temp_right
call Update_Player
inc player_x
call DrawPlayer
call clear_keyboard_buffer
jmp right

jmp temp1_game_sequence

bulletleft:
mov bl, player_x
mov bullet_x, bl
mov bl, player_y
mov bullet_y, bl
cmp bullet_x, 1
je temp4_game_sequence
dec bullet_x
call DrawBullet
cmp bullet_x, 1
je temp4_game_sequence
left:
call compare_enemy1
call compare_enemy2
call compare_enemy3
call compare_enemy6
mov ah, 01h
int 16h
jnz button_pressed_l
mov ah, 86h
mov dx, 10000
int 15h
call DrawBullet
call UpdateBullet
dec bullet_x
call DrawBullet
cmp bullet_x, 1
je temp2_game_sequence
jmp left 
button_pressed_l:
cmp al, 'd'
je moveright_l
cmp al, 'w'
je moveup_l
cmp al, 's'
je movedown_l
cmp al, 'a'
je moveleft_l

call clear_keyboard_buffer
jmp left

moveleft_l:
cmp player_x, 1
je temp_left
call Update_Player
dec player_x
call DrawPlayer
call clear_keyboard_buffer
jmp left

movedown_l:
cmp player_y, 22
je temp_left
call Update_Player
inc player_y
call DrawPlayer
call clear_keyboard_buffer
jmp left

temp_left:
call clear_keyboard_buffer
jmp left

moveup_l:
cmp player_y, 1
je temp_left
call Update_Player
dec player_y
call DrawPlayer
call clear_keyboard_buffer
jmp left
call clear_keyboard_buffer

moveright_l:
cmp player_x, 78
je temp_left
call Update_Player
inc player_x
call DrawPlayer
call clear_keyboard_buffer

jmp left
jmp game_sequence

temp2_game_sequence:
jmp temp1_game_sequence

bulletup:
mov bl, player_x
mov bullet_x, bl
mov bl, player_y
mov bullet_y, bl
cmp bullet_y, 1
je temp2_game_sequence
dec bullet_y
call DrawBullet
cmp bullet_y, 1
je temp2_game_sequence
up:
call compare_enemy1
call compare_enemy2
call compare_enemy3
call compare_enemy6
mov ah, 01h
int 16h
jnz button_pressed_u
mov ah, 86h
mov dx, 25000
int 15h
call DrawBullet
call UpdateBullet
dec bullet_y
call DrawBullet
cmp bullet_y, 1
je temp2_game_sequence
jmp up
button_pressed_u:
cmp al, 'd'
je moveright_u
cmp al, 'w'
je moveup_u
cmp al, 's'
je movedown_u
cmp al, 'a'
je moveleft_u

call clear_keyboard_buffer
jmp up

moveleft_u:
cmp player_x, 1
je temp_up
call Update_Player
dec player_x
call DrawPlayer
call clear_keyboard_buffer
jmp up

temp3_game_sequence:
jmp temp2_game_sequence

movedown_u:
cmp player_y, 22
je temp_up
call Update_Player
inc player_y
call DrawPlayer
call clear_keyboard_buffer
jmp up

temp_up:
call clear_keyboard_buffer
jmp up

moveup_u:
cmp player_y, 1
je temp_up
call Update_Player
dec player_y
call DrawPlayer
call clear_keyboard_buffer
jmp up

moveright_u:
cmp player_x, 78
je temp_up
call Update_Player
inc player_x
call DrawPlayer
call clear_keyboard_buffer

jmp up
jmp game_sequence

temp5_game_sequence:
jmp game_sequence

bulletdown:
mov bl, player_x
mov bullet_x, bl
mov bl, player_y
mov bullet_y, bl
cmp bullet_y, 22
je temp3_game_sequence
inc bullet_y
call DrawBullet
cmp bullet_y, 22
je temp3_game_sequence
down:
call compare_enemy2
call compare_enemy1
call compare_enemy3
call compare_enemy6
mov ah, 01h
int 16h
jnz button_pressed_d
mov ah, 86h
mov dx, 25000
int 15h
call DrawPlayer
call UpdateBullet
inc bullet_y
call DrawBullet
cmp bullet_y, 22
je temp5_game_sequence
jmp down
button_pressed_d:
cmp al, 'd'
je moveright_d
cmp al, 'w'
je moveup_d
cmp al, 's'
je movedown_d
cmp al, 'a'
je moveleft_d

call clear_keyboard_buffer
jmp down

moveleft_d:
cmp player_x, 1
je temp_down
call Update_Player
dec player_x
call DrawPlayer
call clear_keyboard_buffer
jmp down

movedown_d:
cmp player_y, 22
je temp_down
call Update_Player
inc player_y
call DrawPlayer
call clear_keyboard_buffer
jmp down

temp_down:
call clear_keyboard_buffer
jmp down

moveup_d:
cmp player_y, 1
je temp_down
call Update_Player
dec player_y
call DrawPlayer
call clear_keyboard_buffer
jmp down

moveright_d:
cmp player_x, 78
je temp_down
call Update_Player
inc player_x
call DrawPlayer
call clear_keyboard_buffer

jmp down
jmp game_sequence

jmp game_sequence
jmp exit 
cmp al, 3
je exit
high_score:          ;HIGHSCORE
exit:







mov ax, 0002
int 10h
lea dx, exit_prompt1
mov ah, 09h
int 21h
mov dl, 10        ;PRINTING NEW LINE
mov ah, 02h
int 21h 
lea dx, exit_prompt2
mov ah, 09h
int 21h
mov dl, 10        ;PRINTING NEW LINE
mov ah, 02h
int 21h 
lea dx, exit_prompt3
mov ah, 09h
int 21h
mov dl, 10        ;PRINTING NEW LINE
mov ah, 02h
int 21h 
mov dl, 10        ;PRINTING NEW LINE
mov ah, 02h
int 21h 
lea dx, score_prompt
mov ah, 09h
int 21h
mov ax, score
call printax
;mov dl, 20
;mov dh, 5
;mov bh, 0
;mov ah, 02
;int 10h
mov dl, 10        ;PRINTING NEW LINE
mov ah, 02h
int 21h 
lea dx, prompt_time 
mov ah, 09h
int 21h
mov al, starting_minutes
mov ah, 0
;call printax
lea dx, temporary
mov ah, 09h
int 21h
mov al, starting_secs
mov ah, 0
;call printax
lea dx, space
mov ah, 09h
int 21h	
mov ah, 2ch
int 21h
sub cl, starting_minutes
mov al, cl
mov ah, 0
call printax
lea dx, temporary
mov ah, 09h
int 21h
mov ah, 2ch
int 21h
sub dh, starting_secs
mov ax, 0
mov al, dh
mov ah, 0
call printax
mov ah, 4ch
int 21h
main endp

wall proc
mov dl, 0
mov dh, 0
mov bh, 0
mov ah, 2
int 10h
mov cx, 80
l1:
mov dl, '_'
mov ah, 02
int 21h
loop l1
mov dl, 0
mov dh, 1
mov bh, 0
mov ah, 2
int 10h
mov cx, 23
l2:
lea dx, wall_y
mov ah, 09h
int 21h
loop l2
mov dl, 0 
mov dh, 23
mov bh, 0
mov ah, 2
int 10h
mov cx, 80
l3:
mov dl, '`'
mov ah, 02
int 21h
loop l3 
ret
wall endp

UpdateBullet proc
mov dl, bullet_x
mov dh, bullet_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
UpdateBullet endp

DrawBullet proc
mov dl, bullet_x
mov dh, bullet_y
mov bh, 0
mov ah, 02
int 10h
lea dx, bullet
mov ah, 09h
int 21h
ret
DrawBullet endp

clear_keyboard_buffer proc ;FROM STACKOVERFLOW
push ax
push es
mov ax, 0000h
mov es, ax
mov es:[041ah], 041eh
mov es:[041ch], 041eh
pop es
pop ax
ret
clear_keyboard_buffer endp

DrawPlayer proc
mov dl, player_x
mov dh, player_y
mov bh, 0
mov ah, 02
int 10h
mov dl, 2	
mov ah,02h
int 21h
ret
DrawPlayer endp 

Update_Player proc
mov dl, player_x
mov dh, player_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
Update_Player endp

draw_enemy1 proc
mov dl, enemy1_x
mov dh, enemy1_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemy1
mov ah, 09h
int 21h
ret
draw_enemy1 endp

draw_enemy2 proc
mov dl, enemy2_x
mov dh, enemy2_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemy2
mov ah, 09h
int 21h
ret
draw_enemy2 endp

draw_enemy3 proc
mov dl, enemy3_x
mov dh, enemy3_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemy3
mov ah, 09h
int 21h
ret
draw_enemy3 endp

draw_enemy4 proc
mov dl, enemy4_x
mov dh, enemy4_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemy4
mov ah, 09h
int 21h
ret
draw_enemy4 endp

draw_enemy5 proc
mov dl, enemy5_x
mov dh, enemy5_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemy5
mov ah, 09h
int 21h
ret
draw_enemy5 endp

draw_enemy6 proc
mov dl, enemy6_x
mov dh, enemy6_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemy6
mov ah, 09h
int 21h
ret
draw_enemy6 endp

draw_enemy7 proc
mov dl, enemy7_x
mov dh, enemy7_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemy7
mov ah, 09h
int 21h
ret
draw_enemy7 endp

draw_enemy8 proc
mov dl, enemy8_x
mov dh, enemy8_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemy8
mov ah, 09h
int 21h
ret
draw_enemy8 endp

draw_enemy9 proc
mov dl, enemy9_x
mov dh, enemy9_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemy9
mov ah, 09h
int 21h
ret
draw_enemy9 endp

draw_enemyA proc
mov dl, enemyA_x
mov dh, enemyA_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemyA
mov ah, 09h
int 21h
ret
draw_enemyA endp

draw_enemyB proc
mov dl, enemyB_x
mov dh, enemyB_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemyB
mov ah, 09h
int 21h
ret
draw_enemyB endp

draw_enemyC proc
mov dl, enemyC_x
mov dh, enemyC_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemyC
mov ah, 09h
int 21h
ret
draw_enemyC endp

draw_enemyD proc
mov dl, enemyD_x
mov dh, enemyD_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemyD
mov ah, 09h
int 21h
ret
draw_enemyD endp

draw_enemyE proc
mov dl, enemyE_x
mov dh, enemyE_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemyE
mov ah, 09h
int 21h
ret
draw_enemyE endp

draw_enemyF proc
mov dl, enemyF_x
mov dh, enemyF_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemyF
mov ah, 09h
int 21h
ret
draw_enemyF endp

draw_enemyG proc
mov dl, enemyG_x
mov dh, enemyG_y
mov bh, 0
mov ah, 02
int 10h
lea dx, enemyG
mov ah, 09h
int 21h
ret
draw_enemyG endp

draw_life proc
mov dl, life_x
mov dh, life_y
mov bh, 0
mov ah, 02
int 10h
lea dx, life
mov ah, 09h
int 21h
ret
draw_life endp

get_random_enemy1 proc
mov enemy1_y, 1
mov ah, 00h
int 1ah
mov ax, dx
add ax, 15
mov dx, 0
mov bx, 76
div bx
add dl, 1
mov enemy1_x, dl
ret	
get_random_enemy1 endp

get_random_enemy2 proc
mov enemy2_y, 22
mov ah, 00h
int 1ah
mov ax, dx
mov dx, 0
add ax, 9
mov bx, 76
div bx
add dl, 1
mov enemy2_x, dl
ret
get_random_enemy2 endp

get_random_enemy3 proc
mov enemy3_x, 1
mov ah, 00h
int 1ah
mov ax, dx
mov dx, 0 
mov bx, 21
div bx
add dl, 1
mov enemy3_y, dl
ret
get_random_enemy3 endp

get_random_enemy4 proc
mov enemy4_x, 78
mov ah, 00h
int 1ah
mov ax, dx
add ax, 17
mov dx, 0
mov bx, 21
div bx
add dl, 1
mov enemy4_y, dl
ret
get_random_enemy4 endp

get_random_enemy5 proc
mov enemy5_x, 1
mov ah, 00h
int 1ah
mov ax, dx
add ax, 70
mov dx, 0 
mov bx, 21
div bx
add dl, 1
mov enemy5_y, dl
ret
get_random_enemy5 endp

get_random_enemy6 proc
mov enemy6_x, 78
mov ah, 00h
int 1ah
mov ax, dx
add ax, 50
mov dx, 0
mov bx, 21
div bx
add dl, 1
mov enemy6_y, dl
ret
get_random_enemy6 endp

get_random_enemy7 proc
mov enemy7_y, 1
mov ah, 00h
int 1ah
mov ax, dx
add ax, 40
mov dx, 0
mov bx, 76
div bx
add dl, 1
mov enemy7_x, dl
ret
get_random_enemy7 endp

get_random_enemy8 proc
mov enemy8_y, 22 
mov ah, 00h
int 1ah
mov ax, dx
add ax, 77
mov dx, 0
mov bx, 77
div bx
add dl, 1
mov enemy8_x, dl
ret
get_random_enemy8 endp

get_random_enemyA proc
mov enemyA_x, 77 
mov ah, 00h
int 1ah
mov ax, dx
add ax, 77
mov dx, 0
mov bx, 22
div bx
add dl, 1
mov enemyA_y, dl
ret
get_random_enemyA endp

get_random_enemy9 proc
mov enemy9_x, 1 
mov ah, 00h
int 1ah
mov ax, dx
add ax, 77
add ax, 8
mov dx, 0
mov bx, 22
div bx
add dl, 1
mov enemy9_y, dl
ret
get_random_enemy9 endp

get_random_enemyB proc
mov enemyB_y, 1 
mov ah, 00h
int 1ah
mov ax, dx
add ax, 77
mov dx, 0
mov bx, 77
div bx
add dl, 1
mov enemyB_x, dl
ret
get_random_enemyB endp

get_random_enemyC proc
mov enemyC_y, 22
mov ah, 00h
int 1ah
mov ax, dx
add ax, 13
add ax, 33
mov dx, 0
mov bx, 77
div bx
add dl, 1
mov enemyC_x, dl
ret
get_random_enemyC endp

get_random_enemyD proc
mov enemyD_y, 1
mov ah, 00h
int 1ah
mov ax, dx
add ax, 73
add ax, 3
mov dx, 0
mov bx, 77
div bx
add dl, 1
mov enemyD_x, dl
ret
get_random_enemyD endp

get_random_enemyE proc
mov enemyE_y, 22
mov ah, 00h
int 1ah
mov ax, dx
add ax, 13
add ax, 33
mov dx, 0
mov bx, 77
div bx
add dl, 1
mov enemyE_x, dl
ret
get_random_enemyE endp

get_random_enemyF proc
mov enemyF_y, 1
mov ah, 00h
int 1ah
mov ax, dx
add ax, 13
add ax, 33
mov dx, 0
mov bx, 77
div bx
add dl, 1
mov enemyF_x, dl
ret
get_random_enemyF endp

get_random_enemyG proc
mov enemyG_y, 22
mov ah, 00h
int 1ah
mov ax, dx
add ax, 13
add ax, 33
mov dx, 0
mov bx, 77
div bx
add dl, 1
mov enemyG_x, dl
ret
get_random_enemyG endp

get_random_life proc
mov life_y, 1
mov ah, 00h
int 1ah
mov ax, dx
add ax, 13
add ax, 33
mov dx, 0
mov bx, 77
div bx
add dl, 1
mov life_x, dl
ret
get_random_life endp

update_enemy1 proc
mov dl, enemy1_x
mov dh, enemy1_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemy1 endp

update_enemy2 proc
mov dl, enemy2_x
mov dh, enemy2_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemy2 endp

update_enemy3 proc
mov dl, enemy3_x
mov dh, enemy3_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemy3 endp

update_enemy4 proc
mov dl, enemy4_x
mov dh, enemy4_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemy4 endp

update_enemy5 proc
mov dl, enemy5_x
mov dh, enemy5_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemy5 endp

update_enemy6 proc
mov dl, enemy6_x
mov dh, enemy6_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemy6 endp

update_enemy7 proc
mov dl, enemy7_x
mov dh, enemy7_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemy7 endp

update_enemy8 proc
mov dl, enemy8_x
mov dh, enemy8_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemy8 endp

update_enemy9 proc
mov dl, enemy9_x
mov dh, enemy9_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemy9 endp

update_enemyA proc
mov dl, enemyA_x
mov dh, enemyA_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemyA endp

update_enemyB proc
mov dl, enemyB_x
mov dh, enemyB_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemyB endp

update_enemyC proc
mov dl, enemyC_x
mov dh, enemyC_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemyC endp

update_enemyD proc
mov dl, enemyD_x
mov dh, enemyD_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemyD endp

update_enemyE proc
mov dl, enemyE_x
mov dh, enemyE_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemyE endp

update_enemyF proc
mov dl, enemyF_x
mov dh, enemyF_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemyF endp

update_enemyG proc
mov dl, enemyG_x
mov dh, enemyG_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_enemyG endp

update_life proc
mov dl, life_x
mov dh, life_y
mov bh, 0
mov ah, 02
int 10h
lea dx, space
mov ah, 09h
int 21h
ret
update_life endp

compare_enemy1 proc
mov bl, bullet_x
cmp enemy1_x, bl
je yes_x
jmp no
yes_x:
mov bl, bullet_y
cmp enemy1_y, bl
je yes_y
jmp no
yes_y:
call update_enemy1
call get_random_enemy1
inc score
no:
ret
compare_enemy1 endp

compare_enemy2 proc
mov bl, bullet_x
cmp enemy2_x, bl
je yes_x_enemy2_bullet
jmp no_enemy2_bullet
yes_x_enemy2_bullet:
mov bl, bullet_y
cmp enemy2_y, bl
je yes_y_enemy2_bullet
jmp no_enemy2_bullet
yes_y_enemy2_bullet:
call update_enemy2
call get_random_enemy2
inc score
no_enemy2_bullet:
ret
compare_enemy2 endp

compare_enemy3 proc
mov bl, bullet_x
cmp enemy3_x, bl
je yes_x_enemy3_bullet
jmp no_enemy3_bullet
yes_x_enemy3_bullet:
mov bl, bullet_y
cmp enemy3_y, bl
je yes_y_enemy3_bullet
jmp no_enemy3_bullet
yes_y_enemy3_bullet:
call update_enemy3
call get_random_enemy3
inc score
no_enemy3_bullet:
ret
compare_enemy3 endp

compare_enemy6 proc
mov bl, bullet_x
cmp enemy6_x, bl
je yes_x_enemy6_bullet
jmp no_enemy6_bullet
yes_x_enemy6_bullet:
mov bl, bullet_y
cmp enemy6_y, bl
je yes_y_enemy6_bullet
jmp no_enemy6_bullet
yes_y_enemy6_bullet:
call update_enemy6
call get_random_enemy6
inc score
no_enemy6_bullet:
ret
compare_enemy6 endp



compare_player_enemy1 proc
mov bl, player_x
cmp enemy1_x, bl
je yes_x_enemy1
jmp no_enemy1
yes_x_enemy1:
mov bl, player_y
cmp enemy1_y, bl
je yes_y_enemy1
jmp no_enemy1
yes_y_enemy1:
dec lives
call DrawPlayer
call print_lives
no_enemy1:
ret
compare_player_enemy1 endp

compare_player_enemy2 proc
mov bl, player_x
cmp enemy2_x, bl
je yes_x_enemy2
jmp no_enemy2
yes_x_enemy2:
mov bl, player_y
cmp enemy2_y, bl
je yes_y_enemy2
jmp no_enemy2
yes_y_enemy2:
dec lives
call DrawPlayer
call print_lives
no_enemy2:
ret
compare_player_enemy2 endp

compare_player_enemy3 proc
mov bl, player_x
cmp enemy3_x, bl
je yes_x_enemy3
jmp no_enemy3
yes_x_enemy3:
mov bl, player_y
cmp enemy3_y, bl
je yes_y_enemy3
jmp no_enemy3
yes_y_enemy3:
dec lives
call DrawPlayer
call print_lives
no_enemy3:
ret
compare_player_enemy3 endp

compare_player_enemy4 proc
mov bl, player_x
cmp enemy4_x, bl
je yes_x_enemy4
jmp no_enemy4
yes_x_enemy4:
mov bl, player_y
cmp enemy4_y, bl
je yes_y_enemy4
jmp no_enemy4
yes_y_enemy4:
dec lives
call DrawPlayer
call print_lives
no_enemy4:
ret
compare_player_enemy4 endp

compare_player_enemy5 proc
mov bl, player_x
cmp enemy5_x, bl
je yes_x_enemy5
jmp no_enemy5
yes_x_enemy5:
mov bl, player_y
cmp enemy5_y, bl
je yes_y_enemy5
jmp no_enemy5
yes_y_enemy5:
dec lives
call DrawPlayer
call print_lives
no_enemy5:
ret
compare_player_enemy5 endp

compare_player_enemy6 proc
mov bl, player_x
cmp enemy6_x, bl
je yes_x_enemy6
jmp no_enemy6
yes_x_enemy6:
mov bl, player_y
cmp enemy6_y, bl
je yes_y_enemy6
jmp no_enemy6
yes_y_enemy6:
dec lives
call DrawPlayer
call print_lives
no_enemy6:
ret
compare_player_enemy6 endp

compare_player_enemy7 proc
mov bl, player_x
cmp enemy7_x, bl
je yes_x_enemy7
jmp no_enemy7
yes_x_enemy7:
mov bl, player_y
cmp enemy7_y, bl
je yes_y_enemy7
jmp no_enemy7
yes_y_enemy7:
dec lives
call DrawPlayer
call print_lives
no_enemy7:
ret
compare_player_enemy7 endp

compare_player_enemy8 proc
mov bl, player_x
cmp enemy8_x, bl
je yes_x_enemy8
jmp no_enemy8
yes_x_enemy8:
mov bl, player_y
cmp enemy8_y, bl
je yes_y_enemy8
jmp no_enemy8
yes_y_enemy8:
dec lives
call DrawPlayer
call print_lives
no_enemy8:
ret
compare_player_enemy8 endp

compare_player_enemy9 proc
mov bl, player_x
cmp enemy9_x, bl
je yes_x_enemy9
jmp no_enemy9
yes_x_enemy9:
mov bl, player_y
cmp enemy9_y, bl
je yes_y_enemy9
jmp no_enemy9
yes_y_enemy9:
dec lives
call DrawPlayer
call print_lives
no_enemy9:
ret
compare_player_enemy9 endp

compare_player_enemyA proc
mov bl, player_x
cmp enemyA_x, bl
je yes_x_enemyA
jmp no_enemyA
yes_x_enemyA:
mov bl, player_y
cmp enemyA_y, bl
je yes_y_enemyA
jmp no_enemyA
yes_y_enemyA:
dec lives
call DrawPlayer
call print_lives
no_enemyA:
ret
compare_player_enemyA endp

compare_player_enemyB proc
mov bl, player_x
cmp enemyB_x, bl
je yes_x_enemyB
jmp no_enemyB
yes_x_enemyB:
mov bl, player_y
cmp enemyB_y, bl
je yes_y_enemyB
jmp no_enemyB
yes_y_enemyB:
dec lives
call DrawPlayer
call print_lives
no_enemyB:
ret
compare_player_enemyB endp

compare_player_enemyC proc
mov bl, player_x
cmp enemyC_x, bl
je yes_x_enemyC
jmp no_enemyC
yes_x_enemyC:
mov bl, player_y
cmp enemyC_y, bl
je yes_y_enemyC
jmp no_enemyC
yes_y_enemyC:
dec lives
call DrawPlayer
call print_lives
no_enemyC:
ret
compare_player_enemyC endp

compare_player_enemyD proc
mov bl, player_x
cmp enemyD_x, bl
je yes_x_enemyD
jmp no_enemyD
yes_x_enemyD:
mov bl, player_y
cmp enemyC_y, bl
je yes_y_enemyD
jmp no_enemyD
yes_y_enemyD:
dec lives
call DrawPlayer
call print_lives
no_enemyD:
ret
compare_player_enemyD endp

compare_player_enemyE proc
mov bl, player_x
cmp enemyE_x, bl
je yes_x_enemyE
jmp no_enemyE
yes_x_enemyE:
mov bl, player_y
cmp enemyE_y, bl
je yes_y_enemyE
jmp no_enemyE
yes_y_enemyE:
dec lives
call DrawPlayer
call print_lives
no_enemyE:
ret
compare_player_enemyE endp

compare_player_enemyF proc
mov bl, player_x
cmp enemyF_x, bl
je yes_x_enemyF
jmp no_enemyF
yes_x_enemyF:
mov bl, player_y
cmp enemyF_y, bl
je yes_y_enemyF
jmp no_enemyF
yes_y_enemyF:
dec lives
call DrawPlayer
call print_lives
no_enemyF:
ret
compare_player_enemyF endp

compare_player_enemyG proc
mov bl, player_x
cmp enemyG_x, bl
je yes_x_enemyG
jmp no_enemyG
yes_x_enemyG:
mov bl, player_y
cmp enemyG_y, bl
je yes_y_enemyG
jmp no_enemyG
yes_y_enemyG:
dec lives
call DrawPlayer
call print_lives
no_enemyG:
ret
compare_player_enemyG endp

compare_player_life proc
mov bl, player_x
cmp life_x, bl
je yes_x_life
jmp no_life
yes_x_life:
mov bl, player_y
cmp life_y, bl
je yes_y_life
jmp no_life
yes_y_life:
inc lives
call DrawPlayer
call print_lives
no_life:
ret
compare_player_life endp

printax proc
    mov cx, 0
    mov bx, 10
@@loophere:
    mov dx, 0
    div bx                         
    push ax
    add dl, '0'                    
    pop ax                         
    push dx                        
    inc cx                         
    cmp ax, 0                      
jnz @@loophere
    mov ah, 2                     
@@loophere2:
    pop dx                         
    int 21h                        
    loop @@loophere2
    ret
printax endp

print_score_prompt proc
mov dl, 36
mov dh, 0
mov bh, 0
mov ah, 02
int 10h
lea dx, score_prompt
mov ah, 09h
int 21h
ret
print_score_prompt endp

print_lives_prompt proc
mov dl, 36
mov dh, 23
mov bh, 0
mov ah, 02
int 10h
lea dx, lives_prompt
mov ah, 09h
int 21h
ret
print_lives_prompt endp

print_lives proc
mov dl, 43
mov dh, 23
mov bh, 0
mov ah, 02 
int 10h
mov ax, lives
call printax
ret
print_lives endp

print_score proc
mov dl, score_x
mov dh, score_y
mov bh, 0
mov ah, 02
int 10h
mov ax, score
call printax
ret
print_score endp

move_enemy1 proc

game_sequence_enemy1:

cmp enemy1_y, 22
je temp2_end_range_enemy1

cmp enemy2_y, 1
je temp2_end_range_enemy2

cmp enemy3_x, 77
je temp2_end_range_enemy3

cmp enemy4_x, 1
je temp2_end_range_enemy4

cmp enemy5_x, 77
je temp2_end_range_enemy5

jmp continue_temp69
temp2_end_range_enemy1:
jmp temp_end_range_enemy1
temp2_end_range_enemy2:
jmp temp_end_range_enemy2
temp2_end_range_enemy3:
jmp temp_end_range_enemy3
temp2_end_range_enemy4:
jmp temp_end_range_enemy4
temp2_end_range_enemy5:
je temp_end_range_enemy5
continue_temp69:

cmp enemy6_x, 1
je temp_end_range_enemy6

cmp enemy7_y, 22
je temp_end_range_enemy7

cmp enemy8_y, 1
je temp_end_range_enemy8

cmp enemy9_x, 77
je temp_end_range_enemy9

cmp enemyA_x, 1
je temp_end_range_enemyA

cmp enemyB_y, 22
je temp_end_range_enemyB

cmp enemyC_y, 1
je temp_end_range_enemyC

cmp enemyD_y, 22
je temp_end_range_enemyD

cmp enemyE_y, 1
je temp_end_range_enemyE

cmp enemyF_y, 22
je temp_end_range_enemyF

cmp enemyG_y, 1
je temp_end_range_enemyG

cmp life_y, 22
je temp_end_range_life

mov ah, 01h
int 16h
jnz temp_button_pressed_enemy1
mov ah, 86h
mov dx, 0
mov cx, 1
int 15h
jmp continue

temp_end_range_enemy1:
jmp end_range_enemy1

temp_end_range_enemy2:
jmp end_range_enemy2

temp_end_range_enemy3:
jmp end_range_enemy3

temp_end_range_enemy4:
jmp end_range_enemy4

temp_end_range_enemy5:
jmp end_range_enemy5

temp_end_range_enemy7:
jmp end_range_enemy7

temp_end_range_enemy6:
jmp end_range_enemy6

temp_end_range_enemy8:
jmp end_range_enemy8

temp_end_range_enemy9:
jmp end_range_enemy9

temp_end_range_enemyA:
jmp end_range_enemyA

temp_end_range_enemyB:
jmp end_range_enemyB

temp_end_range_enemyC:
jmp end_range_enemyC

temp_end_range_enemyD:
jmp end_range_enemyD

temp_end_range_enemyE:
jmp end_range_enemyE

temp_end_range_enemyF:
jmp end_range_enemyF

temp_end_range_enemyG:
jmp end_range_enemyG

temp_end_range_life:
jmp end_range_life


temp_button_pressed_enemy1:
jmp button_pressed_enemy1

continue:
call update_enemy1
inc enemy1_y
call draw_enemy1
call update_enemy2
dec enemy2_y
call draw_enemy2
call update_enemy3
inc enemy3_x
call draw_enemy3
call update_enemy4
dec enemy4_x
call draw_enemy4
call update_enemy5
inc enemy5_x
call draw_enemy5
call update_enemy6
dec enemy6_x
call draw_enemy6
call update_enemy7
inc enemy7_y
call draw_enemy7
call update_enemy8
dec enemy8_y
call draw_enemy8
call update_enemy9
inc enemy9_x
call draw_enemy9
call update_enemyA
dec enemyA_x
call draw_enemyA
call update_enemyB
inc enemyB_y
call draw_enemyB
call update_enemyC
dec enemyC_y
call draw_enemyC
call update_life
inc life_y
call draw_life

cmp score, 10
jae yes_enemyD_enemyE
jmp nope

yes_enemyD_enemyE:
call update_enemyD
inc enemyD_y
call draw_enemyD
call update_enemyE
dec enemyE_y
call draw_enemyE

nope:

cmp score, 15
jae yes_enemyF_enemyG
jmp nope_FG

yes_enemyF_enemyG:
call update_enemyF
inc enemyF_y
call draw_enemyF
call update_enemyG
dec enemyG_y
call draw_enemyG

nope_FG:
call print_score

call compare_player_enemy1
cmp lives, 0
je temp3_exit_enemy1

call compare_player_enemy2
cmp lives, 0
je temp3_exit_enemy1


call compare_player_enemy3
cmp lives, 0
je temp3_exit_enemy1

jmp continue_temp
temp3_exit_enemy1:
jmp temp2_exit_enemy1
continue_temp:


call compare_player_enemy4
cmp lives, 0
je temp2_exit_enemy1

call compare_player_enemy5
cmp lives, 0
je temp2_exit_enemy1

call compare_player_enemy6
cmp lives, 0
je temp2_exit_enemy1

call compare_player_enemy7
cmp lives, 0
je temp2_exit_enemy1

call compare_player_enemy8
cmp lives, 0
je temp2_exit_enemy1

call compare_player_enemy9
cmp lives, 0
je temp2_exit_enemy1

call compare_player_enemyA
cmp lives, 0
je temp2_exit_enemy1

call compare_player_enemyB
cmp lives, 0
je temp2_exit_enemy1

call compare_player_enemyC
cmp lives, 0
je temp2_exit_enemy1

call compare_player_enemyD
cmp lives, 0
je temp2_exit_enemy1

call compare_player_enemyE
cmp lives, 0
je temp2_exit_enemy1

call compare_player_enemyF
cmp lives, 0
je temp2_exit_enemy1

call compare_player_enemyG
cmp lives, 0
je temp2_exit_enemy1

call compare_player_life

jmp game_sequence_enemy1

temp2_exit_enemy1:
jmp temp_exit_enemy1

temp_game_sequence_enemy1:
call clear_keyboard_buffer
jmp game_sequence_enemy1

button_pressed_enemy1:
cmp al, 'x'
je temp_exit_enemy1
cmp al, 'w'
je moveup_enemy1
cmp al, 's'
je movedown_enemy1
cmp al, 'd'
je moveright_enemy1
cmp al, 'a'
je moveleft_enemy1
call clear_keyboard_buffer
jmp game_sequence_enemy1

moveright_enemy1:
cmp player_x, 78
je temp_game_sequence_enemy1
call Update_Player
inc player_x
call DrawPlayer
call clear_keyboard_buffer
jmp game_sequence_enemy1

temp_exit_enemy1:
jmp exit_enemy1

moveleft_enemy1:
cmp player_x, 1
je temp_game_sequence_enemy1
call Update_Player
dec player_x
call DrawPlayer
call clear_keyboard_buffer
jmp game_sequence_enemy1

movedown_enemy1:
cmp player_y, 22
je temp_game_sequence_enemy1
call Update_Player
inc player_y
call DrawPlayer
call clear_keyboard_buffer
jmp game_sequence_enemy1

moveup_enemy1:
cmp player_y, 1
je temp_game_sequence_enemy1
call Update_Player
dec player_y
call DrawPlayer
call clear_keyboard_buffer
jmp game_sequence_enemy1

jmp game_sequence_enemy1

end_range_enemy1:
call draw_enemy1
inc score
call print_score
call update_enemy1
call get_random_enemy1
call draw_enemy1

jmp game_sequence_enemy1
end_range_enemy2:
call draw_enemy2
call print_score
call update_enemy2
call get_random_enemy2
call draw_enemy2
jmp game_sequence_enemy1

end_range_enemy3:
inc score
call draw_enemy3
call print_score
call update_enemy3
call get_random_enemy3
call draw_enemy3
jmp game_sequence_enemy1

end_range_enemy4:
call draw_enemy4
;inc score
call print_score
call update_enemy4
call get_random_enemy4
call draw_enemy4
jmp game_sequence_enemy1

end_range_enemy5:
inc score
call draw_enemy3
call print_score
call update_enemy5
call get_random_enemy5
call draw_enemy5
jmp game_sequence_enemy1

end_range_enemy6:
call draw_enemy6
call print_score
call update_enemy6
call get_random_enemy6
call draw_enemy6
jmp game_sequence_enemy1

end_range_enemy7:
call update_enemy7
call print_score
call update_enemy7
call get_random_enemy7
call draw_enemy7
jmp game_sequence_enemy1

end_range_enemy8:
call draw_enemy8
call print_score
call update_enemy8
call get_random_enemy8
call draw_enemy8
jmp game_sequence_enemy1

end_range_enemy9:
call draw_enemy9
call print_score
call update_enemy9
call get_random_enemy9
call draw_enemy9
jmp game_sequence_enemy1

end_range_enemyA:
call update_enemyA
call print_score
call update_enemyA
call get_random_enemyA
call draw_enemyA
jmp game_sequence_enemy1

end_range_enemyB:
call update_enemyB
call print_score
call update_enemyB
call get_random_enemyB
call draw_enemyB
jmp game_sequence_enemy1

end_range_enemyC:
call update_enemyC
call print_score
call update_enemyC
call get_random_enemyC
call draw_enemyC
jmp game_sequence_enemy1

end_range_enemyD:
call update_enemyD
call print_score
call update_enemyD
call get_random_enemyD
call draw_enemyD
jmp game_sequence_enemy1

end_range_enemyE:
call update_enemyE
call print_score
call update_enemyE
call get_random_enemyE
call draw_enemyE
jmp game_sequence_enemy1

end_range_enemyF:
call update_enemyF
call print_score
call update_enemyF
call get_random_enemyF
call draw_enemyF
jmp game_sequence_enemy1

end_range_enemyG:
call update_enemyG
call print_score
call update_enemyG
call get_random_enemyG
call draw_enemyG
jmp game_sequence_enemy1

end_range_life:
call update_life
call print_score
call update_life
call get_random_life
call draw_life
jmp game_sequence_enemy1

jmp game_sequence_enemy1

exit_enemy1:
jmp exit_temp
ret
move_enemy1 endp

get_time proc
mov cx, 0
mov dx, 0
mov ah, 2ch
int 21h
mov al, cl
mov ah, 0
call printax
lea dx, temporary
mov ah, 09h
int 21h
mov ah, 2ch
int 21h
mov ax, 0
mov al, dh
mov ah, 0
call printax
ret
get_time endp

end main