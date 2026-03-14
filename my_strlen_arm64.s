.text
.global _my_strlen

_my_strlen:
    mov     x1, x0          
    mov     x0, #0          
.loop:
    ldrb    w2, [x1], #1    
    cbz     w2, .done       
    add     x0, x0, #1      
    b       .loop           
.done:
    ret
