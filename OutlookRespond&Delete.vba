Sub DeclineAndDelete()

    Dim cAppt As AppointmentItem
    Set cAppt = Application.ActiveExplorer.Selection.Item(1).GetAssociatedAppointment(True)

    ' Mark item as read
    Application.ActiveExplorer.Selection.Item(1).UnRead = False

    If cAppt.ResponseRequested = True Then ' check if a response is needed
        Dim oResponse As MeetingItem
        Set oResponse = cAppt.Respond(olMeetingDeclined, True)
        oResponse.Send

        ' Clear selection if a response is sent
        Application.ActiveExplorer.CurrentFolder.Items(1).Display
        Application.ActiveExplorer.ClearSelection
        Application.ActiveExplorer.Selection.Item(1).Delete
    Else ' if no response is needed, just decline the meeting without sending a response
        cAppt.Respond (olMeetingDeclined)
        Application.ActiveExplorer.Selection.Item(1).Delete
    End If


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

        ' Mark next item as read
        Application.ActiveExplorer.CurrentFolder.Items(1).Display
        Application.ActiveExplorer.ClearSelection
    Else ' if no response is needed, just accept the meeting without sending a response
        cAppt.Respond (olMeetingAccepted)

    End If


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
        oResponse.Body = "Automated Message: Thanks but I will not be able to attend, please slack/email me for more details"
        oResponse.Send

        Application.ActiveExplorer.Selection.Item(1).Delete

        ' Mark next item as read
        Application.ActiveExplorer.CurrentFolder.Items(1).Display
        Application.ActiveExplorer.ClearSelection
    Else ' if no response is needed, just decline the meeting without sending a response
        cAppt.Respond (olMeetingDeclined)
        Application.ActiveExplorer.Selection.Item(1).Delete
    End If


    Set cAppt = Nothing
    Set oResponse = Nothing

End Sub