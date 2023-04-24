Sub DeclineAndDelete()

    Dim cAppt As AppointmentItem
    Set cAppt = Application.ActiveExplorer.Selection.Item(1).GetAssociatedAppointment(True)
    
    ' Mark item as read
    Application.ActiveExplorer.Selection.Item(1).UnRead = False
    
    Dim oResponse As MeetingItem
    Set oResponse = cAppt.Respond(olMeetingDeclined, True)
    oResponse.Send
   
    Application.ActiveExplorer.Selection.Item(1).Delete
    
    Set cAppt = Nothing
    Set oResponse = Nothing

End Sub

Sub AcceptAndDelete()

    Dim cAppt As AppointmentItem
    Set cAppt = Application.ActiveExplorer.Selection.Item(1).GetAssociatedAppointment(True)
    
    ' Mark item as read
    Application.ActiveExplorer.Selection.Item(1).UnRead = False
    
    Dim oResponse As MeetingItem
    Set oResponse = cAppt.Respond(olMeetingAccepted, True)
    oResponse.Send
    Application.ActiveExplorer.Selection.Item(1).Delete
    
    Set cAppt = Nothing
    Set oResponse = Nothing

End Sub

Sub DeclineandMessage()

    Dim cAppt As AppointmentItem
    Set cAppt = Application.ActiveExplorer.Selection.Item(1).GetAssociatedAppointment(True)
    
    ' Mark item as read
    Application.ActiveExplorer.Selection.Item(1).UnRead = False
    
    Dim oResponse As MeetingItem
    Set oResponse = cAppt.Respond(olMeetingDeclined, True)
    
    ' Add message here
    oResponse.Body = "Automated Message: Thanks but I will not be able to attend, please slack/email me for more details"
    
    oResponse.Send
    Application.ActiveExplorer.Selection.Item(1).Delete
    
    Set cAppt = Nothing
    Set oResponse = Nothing

End Sub
