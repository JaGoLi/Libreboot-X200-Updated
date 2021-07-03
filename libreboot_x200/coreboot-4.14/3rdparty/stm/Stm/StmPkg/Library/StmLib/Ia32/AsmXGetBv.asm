;------------------------------------------------------------------------------
;
; Copyright (c) 2015, Intel Corporation. All rights reserved.<BR>
; This program and the accompanying materials
; are licensed and made available under the terms and conditions of the BSD License
; which accompanies this distribution.  The full text of the license may be found at
; http://opensource.org/licenses/bsd-license.php.
;
; THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
; WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
; 
; Module Name:
;
;    AsmXGetBv.asm
;
;------------------------------------------------------------------------------

.686p
.MODEL flat,c
.CODE

AsmXGetBv PROC PUBLIC
    mov     ecx, [esp + 4]
    db      0fh, 01h, 0d0h ; xgetbv
    ret
AsmXGetBv  ENDP

END
