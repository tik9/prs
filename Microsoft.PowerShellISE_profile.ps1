function Comment { 
    if ($psISE.CurrentFile.Editor.SelectedText.Length -gt 0) { 
        $string = $psISE.CurrentFile.Editor.SelectedText 
        $string = "#" + $string.Replace("`n", "`n#") 
        $psISE.CurrentFile.Editor.InsertText($string) 
    } 
    else { 
        $psISE.CurrentFile.Editor.SelectCaretLine() 
        $psISE.CurrentFile.Editor.InsertText("#" + $psISE.CurrentFile.Editor.CaretLineText) 
    } 
} 
 
function UnComment { 
    if ($psISE.CurrentFile.Editor.SelectedText.Length -gt 0) { 
        $string = $psISE.CurrentFile.Editor.SelectedText 
        $psISE.CurrentFile.Editor.InsertText($string.trimStart("#").Replace("`n#", "`n")) 
    } 
    else { 
        $psISE.CurrentFile.Editor.SelectCaretLine() 
        $psISE.CurrentFile.Editor.InsertText($psISE.CurrentFile.Editor.CaretLineText.trimStart("#")) 
    } 
} 

$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add("Comment", { Comment }, "ALT+F5") | out-Null 
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add("Uncomment", { UnComment }, "ALT+F6") | out-Null

#Set-Location C:\Users\akngdxq\Documents