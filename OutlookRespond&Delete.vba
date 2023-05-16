Sub DeclineAndDelete()

    Dim cAppt As AppointmentItem
    Set cAppt = Application.ActiveExplorer.Selection.Item(1).GetAssociatedAppointment(True)

    ' Mark item as read
    Application.ActiveExplorer.Selection.Item(1).UnRead = False

    ' Check if the meeting is cancelled
    If cAppt.MeetingStatus = olMeetingCanceled Then
        ' Delete the meeting
        cAppt.Delete
    Else
        If cAppt.ResponseRequested = True Then ' check if a response is needed
            Dim oResponse As MeetingItem
            Set oResponse = cAppt.Respond(olMeetingDeclined, True)
            oResponse.Send

            Application.ActiveExplorer.Selection.Item(1).Delete
        Else ' if no response is needed, just decline the meeting without sending a response
            cAppt.Respond (olMeetingDeclined)
            Application.ActiveExplorer.Selection.Item(1).Delete
        End If
    End If

    ' Mark first item in Deleted Items folder as read
    'Application.ActiveExplorer.CurrentFolder.Parent.Folders("Deleted Items").Items(1).UnRead = False

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


    Else ' if no response is needed, just decline the meeting without sending a response
        cAppt.Respond (olMeetingDeclined)
        Application.ActiveExplorer.Selection.Item(1).Delete
    End If

    ' Mark first item in Deleted Items folder as read
    'Application.ActiveExplorer.CurrentFolder.Parent.Folders("Deleted Items").Items(1).UnRead = False

    Set cAppt = Nothing
    Set oResponse = Nothing

End Sub