Private Sub Application_NewMailEx(ByVal EntryIDCollection As String)

'This macro declines all meeting requests that are sent from Product Club or AMPO Communications.

Dim objOL As Outlook.Application
Dim objMeeting As Outlook.MeetingItem
Dim objAppt As Outlook.AppointmentItem
Dim arrEntryID() As String
Dim intCounter As Integer

'Split the EntryIDCollection into an array
arrEntryID = Split(EntryIDCollection, ",")

'Get the Outlook instance
Set objOL = Outlook.Application

'Loop through the EntryID array
For intCounter = 0 To UBound(arrEntryID)

'Check if the Entry ID is valid
If arrEntryID(intCounter) <> "" Then

'Get the meeting request by Entry ID
Set objMeeting = objOL.Session.GetItemFromID(arrEntryID(intCounter))

'Check if the sender's email address is from Product Club or AMPO Communications
If InStr(1, LCase(objMeeting.SenderEmailAddress), "productclub", vbTextCompare) > 0 _
Or InStr(1, LCase(objMeeting.SenderEmailAddress), "ampo.communications", vbTextCompare) > 0 _
Then

'Get the associated appointment
Set objAppt = objMeeting.GetAssociatedAppointment(True)

'Decline the meeting request
Set objMeeting = objAppt.Respond(olMeetingDeclined, True)
objMeeting.Body = "Automated Message: Thanks but I will not be able to attend"

'Send the response
objMeeting.Send

'Delete the appointment
objAppt.Delete

'Check to make sure the appointment was actually deleted
If Not objAppt.Exists Then
Debug.Print "Appointment deleted successfully."
End If

End If

End If 'end of checking if the Entry ID is valid

Next intCounter

'Release objects from memory
Set objOL = Nothing
Set objMeeting = Nothing
Set objAppt = Nothing

End Sub
