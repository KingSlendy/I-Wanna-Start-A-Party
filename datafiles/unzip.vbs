' Arguments
zipFile = WScript.Arguments(0)
destDir = WScript.Arguments(1)

' Check if the zip file exists
Set fso = CreateObject("Scripting.FileSystemObject")
If Not fso.FileExists(zipFile) Then
    WScript.Echo "Zip file does not exist: " & zipFile
    WScript.Quit(1)
End If

' Check if the destination directory exists, if not create it
If Not fso.FolderExists(destDir) Then
    fso.CreateFolder(destDir)
End If

' Unzip the file
On Error Resume Next ' Enable error handling
Set objShell = CreateObject("Shell.Application")
If objShell Is Nothing Then
    WScript.Echo "Failed to create Shell.Application object."
    WScript.Quit(1)
End If

Set source = objShell.NameSpace(zipFile)
If source Is Nothing Then
    WScript.Echo "Failed to access the zip file: " & zipFile
    WScript.Quit(1)
End If

Set destination = objShell.NameSpace(destDir)
If destination Is Nothing Then
    WScript.Echo "Failed to access the destination directory: " & destDir
    WScript.Quit(1)
End If

destination.CopyHere source.Items, 16
If Err.Number <> 0 Then
    WScript.Echo "An error occurred while unzipping: " & Err.Description
    WScript.Quit(1)
End If
On Error GoTo 0 ' Disable error handling