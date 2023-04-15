        Private Sub Application_NewMailEx(ByVal EntryIDCollection As String)
        
        Dim objOL As Outlook.Application
        Dim objMeeting As Outlook.MeetingItem
        Dim objAppt As Outlook.AppointmentItem
        Dim arrEntryID() As String
        Dim intCounter As Integer
        
        arrEntryID = Split(EntryIDCollection, ",")
        
        On Error Resume Next
        
        'Get the Outlook instance
        Set objOL = Outlook.Application
        
        If Not (objOL Is Nothing) Then
            
            'Loop through the EntryID array
            For intCounter = 0 To UBound(arrEntryID)
            
                'Check if the Entry ID is valid
                If arrEntryID(intCounter) <> "" Then
                
                    'Get the meeting request by Entry ID
                    Set objMeeting = objOL.Session.GetItemFromID(arrEntryID(intCounter))
                    
                    If Not (objMeeting Is Nothing) Then
                        
                                'Check if the sender's email address matches the specified email addresses
                    If InStr(1, LCase(objMeeting.SenderEmailAddress), "productclub", vbTextCompare) > 0 _
                    Or InStr(1, LCase(objMeeting.SenderEmailAddress), "ampo.communications", vbTextCompare) > 0 _
 Then
                        
                            Set objAppt = objMeeting.GetAssociatedAppointment(True)
                                            'Decline the meeting request
                    Set objMeeting = objAppt.Respond(olMeetingDeclined, True)
                    objMeeting.Body = "Automated Message: Thanks but I will not be able to attend"
                    
                    objMeeting.Send
                        
                    'Delete the appointment and the meeting request
                    objAppt.Delete
                            
                            objAppt.UnRead = False
                            'Delete the appointment and the meeting request
                            objAppt.Delete
                            
                        End If
                    End If
                    
                End If 'end of checking if the Entry ID is valid
                
            Next intCounter
        End If
        
        'Release objects from memory
        Set objOL = Nothing
        Set objMeeting = Nothing
        Set objAppt = Nothing
        
    End Sub
    
        
    ErrorHandler:
        'Handle any errors that occur during the code execution
        Debug.Print "Error: " & Err.Number & ", " & Err.Description
        Resume Next
        
    End Sub
