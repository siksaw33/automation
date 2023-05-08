Sub DeclineAndDelete()

    Dim cAppt As AppointmentItem
    Set cAppt = Application.ActiveExplorer.Selection.Item(1).GetAssociatedAppointment(True)

    ' Mark item as read
    Application.ActiveExplorer.Selection.Item(1).UnRead = False

    If cAppt.ResponseRequested = True Then ' check if a response is needed
        Dim oResponse As MeetingItem
        Set oResponse = cAppt.Respond(olMeetingDeclined, True)
        oResponse.Send
    Else ' if no response is needed, just decline the meeting without sending a response
        cAppt.Decline
    End If

    Application.ActiveExplorer.Selection.Item(1).Delete

    ' Mark next item as read
    Application.ActiveExplorer.ClearSelection
    Application.ActiveExplorer.CurrentFolder.Items(1).Display
    Application.ActiveExplorer.ClearSelection

    Set cAppt = Nothing
    Set oResponse = Nothing

End Sub

Sub AcceptAndDelete()

    Dim cAppt As AppointmentItem
    Set cAppt = Application.ActiveExplorer.Selection.Item(1).GetAssociatedAppointment(True)

    ' Mark item as read
    Application.ActiveExplorer.Selection.Item(1).UnRead = False

    If cAppt.ResponseRequested = True Then ' check if a response is needed
        Dim oResponse As MeetingItem
        Set oResponse = cAppt.Respond(olMeetingAccepted, True)
        oResponse.Send
    Else ' if no response is needed, just accept the meeting without sending a response
        cAppt.Accept
    End If

    Application.ActiveExplorer.Selection.Item(1).Delete

    ' Mark next item as read
    Application.ActiveExplorer.ClearSelection
    Application.ActiveExplorer.CurrentFolder.Items(1).Display
    Application.ActiveExplorer.ClearSelection

    Set cAppt = Nothing
    Set oResponse = Nothing

End Sub

Sub DeclineandMessage()

    Dim cAppt As AppointmentItem
    Set cAppt = Application.ActiveExplorer.Selection.Item(1).GetAssociatedAppointment(True)

    ' Mark item as read
    Application.ActiveExplorer.Selection.Item(1).UnRead = False

    If cAppt.ResponseRequested = True Then ' check if a response is needed
        Dim oResponse As MeetingItem
        Set oResponse = cAppt.Respond(olMeetingDeclined, True)
        ' Add message here
        oResponse.Body = "Automated Message: Thanks but I will not be able to attend, please slack/email me for more details"
        oResponse.Send
    Else ' if no response is needed, just decline the meeting without sending a response
        cAppt.Decline
    End If

    Application.ActiveExplorer.Selection.Item(1).Delete

    ' Mark next item as read
    Application.ActiveExplorer.ClearSelection
    Application.ActiveExplorer.CurrentFolder.Items(1).Display
    Application.ActiveExplorer.ClearSelection

    Set cAppt = Nothing
    Set oResponse = Nothing

End Sub
