Sub CreateSenderFolderAndRule()
    Dim objNS As Outlook.NameSpace
    Dim objInbox As Outlook.MAPIFolder
    Dim objMail As Outlook.MailItem
    Dim objSenderFolder As Outlook.MAPIFolder
    Dim strFolderName As String
    Dim objRules As Outlook.Rules
    Dim objRule As Outlook.Rule
    Dim objCondition As Outlook.RuleCondition
    Dim objAction As Outlook.RuleAction
    Dim objRuleExec As Object
    
    ' Get reference to the inbox
    Set objNS = Application.GetNamespace("MAPI")
    Set objInbox = objNS.GetDefaultFolder(olFolderInbox)
    
    ' Check if there is a selected item
    If Application.ActiveExplorer.Selection.Count = 0 Then
        MsgBox "Please select a message to create a folder for."
        Exit Sub
    End If
    
    ' Get the selected item (should be a mail item)
    Set objMail = Application.ActiveExplorer.Selection.Item(1)
    
    ' Check if the sender of the email is already a folder
    On Error Resume Next
    Set objSenderFolder = objInbox.Folders(objMail.SenderName)
    On Error GoTo 0
    
    ' If the folder does not exist, create it
    If objSenderFolder Is Nothing Then
        ' Create a folder with the name of the sender
        strFolderName = objMail.SenderName
        Set objSenderFolder = objInbox.Folders.Add(strFolderName, olFolderInbox)
    End If
    
    ' Create a rule to move new messages from the sender to the new folder
    Set objRules = Application.Session.DefaultStore.GetRules()
    
    ' Temporarily disable all existing rules
    Dim objExistingRule As Outlook.Rule
    For Each objExistingRule In objRules
        objExistingRule.Enabled = False
    Next objExistingRule
    
    ' Create the new rule
    Set objRule = objRules.Create("Move messages from " & objMail.SenderName, olRuleReceive)
    Set objCondition = objRule.Conditions.SenderAddress
    With objCondition
        .Enabled = True
        .Address = objMail.SenderEmailAddress
    End With
    Set objAction = objRule.Actions.MoveToFolder
    With objAction
        .Enabled = True
        .ExecutionOrder = 1 ' Ensure the rule is executed before other rules
        .Folder = objSenderFolder
    End With
    objRule.Enabled = True
    
    ' Re-enable the existing rules
    For Each objExistingRule In objRules
        objExistingRule.Enabled = True
    Next objExistingRule
    
    ' Save the rules
    objRules.Save
    
    ' Debugging code to check the rules after the new one has been created
    Debug.Print "Number of rules: " & objRules.Count
    For Each objExistingRule In objRules
        Debug.Print objExistingRule.Name & " - " & objExistingRule.Enabled
    Next objExistingRule
    
    ' Execute the rule
    Set objRuleExec = Application.Session.DefaultStore.GetRules.ExecuteRule(objRule.Name)
    
    ' Success message
    MsgBox "Created folder: " & objSenderFolder.Name & vbCrLf & "Created rule: " & objRule.Name
End Sub
