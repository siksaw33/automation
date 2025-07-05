#Requires AutoHotkey v2.0+
#SingleInstance Force

SetWorkingDir A_ScriptDir

;-------------------------------------------------------------------------------
; Define Hotstrings for Sending Texts (Always Active)

; Single-line hotstrings
::@@::sikandersawhney@gmail.com
::@2::siksaw33@gmail.com
::@1::sikander.sawhney@aexp.com
::@ads::ssawh6  ; Sends "ssawh6" directly

; Multi-line hotstrings using continuation sections
::lorem0::
(
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    Nullam blandit pharetra velit ut mattis.
    Vestibulum sollicitudin elit id nisl eleifend, vulputate aliquet quam lobortis
)

::dt::
{
    now := FormatTime(A_Now, "yyyy-MM-dd H:mm:ss")
    Send(now)
}

::@lines::
{
    Send("ligne 1`rligne 2`rligne 3`rligne 4`rligne 5")
}

::lorem::
(
    Regio congestaque instabilis habitabilis reparabat nitidis quem nullo natus. Fuerat undas vesper ne illis pluvialibus coercuit. Volucres numero pendebat inter fuerant inminet tanta. Numero grandia diremit uno terra ventis motura membra obliquis. Moles sive nam nullus undas. Valles nix fuerant premuntur sunt montibus.
)

::lorem2::
(
    Vestibulum consectetur lacus neque, sed cursus sem dictum sed. Ut commodo, mauris a scelerisque feugiat, leo orci pulvinar elit, at convallis urna lacus ac diam. Phasellus tincidunt blandit justo sit amet vestibulum. Aenean iaculis sodales rhoncus. Mauris eleifend ac dui quis sagittis. Nulla ut fringilla odio. Etiam posuere lacus felis, ut tristique arcu porttitor ut. Pellentesque eget velit eu magna consequat hendrerit. Donec sit amet sollicitudin dui. Nullam dapibus suscipit nulla, vel aliquet risus facilisis in. Pellentesque efficitur ut augue quis malesuada. Mauris luctus risus sit amet lorem pretium, vel euismod nisl ultricies. Ut justo felis, dapibus a ipsum vitae, tristique vehicula nibh. Ut semper sem id auctor imperdiet. Fusce sed magna sit amet ante bibendum vestibulum id sit amet nibh.
)

::lorem3::
(
    Nulla sed elementum eros. Nullam dignissim nisi sit amet diam efficitur sagittis. Maecenas at tellus tellus. Aenean vel nunc libero. Nunc feugiat luctus egestas. Nunc dapibus efficitur nisl sed sollicitudin. Cras convallis sit amet sapien sit amet pharetra. Mauris dignissim libero sit amet tellus convallis tempor.
)

::lorem4::
(
    Fusce auctor dui cursus, commodo nisi vel, elementum nulla. Nam et porttitor ligula. Integer vitae tortor non nunc hendrerit auctor vitae eu arcu. Integer at urna neque. Vestibulum vitae justo congue, laoreet elit eget, efficitur nunc. Aenean sit amet fringilla orci. Vestibulum posuere vitae leo vitae tincidunt. Sed in dictum nisi. In ut mi eu quam placerat rhoncus ut ac est. Sed gravida placerat dolor, sed pellentesque odio venenatis quis. Cras vel pellentesque ipsum, quis semper sem. Cras varius leo sed augue commodo finibus. Phasellus aliquet euismod velit id sodales. Cras vulputate nibh non laoreet porta. Quisque hendrerit ut est vitae congue. Fusce eleifend eu dolor a ultricies.
)

::lorem5::
(
    Suspendisse venenatis risus vel metus porttitor, in pharetra est pretium. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce nec tellus nulla. Vestibulum scelerisque nunc tellus. Phasellus fermentum, dui mollis malesuada scelerisque, massa turpis pretium justo, et tempus ex nulla viverra dui. Etiam at pretium orci. In venenatis sapien a molestie aliquet. Aenean sit amet risus tristique neque egestas feugiat id ut tellus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin aliquet eros quis velit aliquet blandit.
)

;-------------------------------------------------------------------------------
; Define Hotkeys for Custom Actions

; Send Text using Ctrl + Alt + P
^!p::Send("K6.c~nf29Y-Z")
;-------------------------------------------------------------------------------
; Blackout Screens & Mouse Jiggler (Ctrl + Alt + L)
^!l::toggle_black_mouse()

toggle_black_mouse() {
    static blackout_enabled := false
    static jiggle_enabled := false
    static gui_list := []

    blackout_enabled := !blackout_enabled
    jiggle_enabled := blackout_enabled  ; Sync mouse jiggler with blackout state

    ; Toggle Blackout Screens
    if blackout_enabled {
        loop MonitorGetCount() {
            MonitorGet(A_Index, &l, &t, &r, &b)
            gui_list.Push(make_black_overlay(l, t, r, b))
        }
    } else {
        for _, goo in gui_list 
            goo.Destroy()
        gui_list := []
    }

    ; Toggle Mouse Jiggler
    if jiggle_enabled {
        SetTimer(jiggle_mouse, 30000)  ; Move every 30 seconds
        ToolTip("Black Mouse is ON - Screens are Blacked Out", , 1)
    } else {
        SetTimer(jiggle_mouse, 0)  ; Disable
        ToolTip("Black Mouse is OFF - Screens Restored", , 1)
    }
    
    Sleep 2000
    ToolTip("")  ; Hide tooltip
}

make_black_overlay(l, t, r, b) {
    x := l, y := t, w := Abs(l+r), h := Abs(t+b)
    ,goo := Gui('+AlwaysOnTop -Caption -DPIScale')
    ,goo.BackColor := 0x0
    ,goo.Show()
    ,goo.Move(x, y, w, h)
    return goo
}

jiggle_mouse() {
    MouseMove(1, 1, 0, "R")  ; Move right-down by 1 pixel
    Sleep 50
    MouseMove(-1, -1, 0, "R")  ; Move back to original position
}

;-------------------------------------------------------------------------------
; Show Tooltip When CapsLock is Toggled
~CapsLock::
{
    Sleep 100  ; Wait for CapsLock state to change
    if GetKeyState("CapsLock", "T")
        ToolTip("CapsLock is now ON - Custom hotkeys are active.")
    else
        ToolTip("CapsLock is now OFF - Custom hotkeys are inactive.")
    Sleep 2000
    ToolTip("")  ; Clear the tooltip after 2 seconds
}

;-------------------------------------------------------------------------------
; Only Enable Custom Hotkeys When CapsLock is ON
#HotIf GetKeyState("CapsLock", "T")

    ; Replace specific keys with Ctrl shortcuts
    c::Send("^c")  ; Pressing "c" behaves as Ctrl + C
    ;x::Send("^x")  ; Pressing "x" behaves as Ctrl + X
    v::Send("^v")  ; Pressing "v" behaves as Ctrl + V
    ;z::Send("^z")  ; Pressing "z" behaves as Ctrl + Z
    ;b::Send("^b")  ; Pressing "b" behaves as Ctrl + B

#HotIf  ; Ends the #HotIf condition

;-------------------------------------------------------------------------------
; Blackout Smallest Screen (Ctrl + Alt + K)
^!k::BlackoutSmallest()

BlackoutSmallest() {
    static gui_list := []                                    ; Stores a list of active guis
    
    if (gui_list.Length > 0) {                               ; If blackout is already active
        for _, goo in gui_list                               ; Destroy all GUIs
            goo.Destroy()
        gui_list := []
        return
    }

    smallestIndex := 0
    smallestSize := 99999999  ; Arbitrary large number

    loop MonitorGetCount() {                                ; Loop through all monitors
        MonitorGet(A_Index, &l, &t, &r, &b)
        width := Abs(r - l)
        height := Abs(b - t)
        size := width * height                              ; Calculate screen area

        if (size < smallestSize) {                          ; Find the smallest monitor
            smallestSize := size
            smallestIndex := A_Index
        }
    }

    if (smallestIndex > 0) {                                ; If a smallest monitor is found
        MonitorGet(smallestIndex, &l, &t, &r, &b)
        gui_list.Push(create_black_overlay(l, t, r, b))     ; Blackout the smallest screen
    }
}

create_black_overlay(l, t, r, b) {
    x := l, y := t, w := Abs(r - l), h := Abs(b - t)
    ,goo := Gui('+AlwaysOnTop -Caption -DPIScale')
    ,goo.BackColor := 0x0
    ,goo.Show()
    ,goo.Move(x, y, w, h)
    return goo
}
