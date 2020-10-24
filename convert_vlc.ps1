function ConvertToMp3 ($inputObject, [switch]$isRemoveOldFile = $false)
{
    $vlc = "C:\Program Files\VideoLAN\VLC\vlc.exe"
    $codec = 'mp3';
    $oldFile = $inputObject;

    $newFile = $_.FullName.Replace("'", "\'").Replace($_.Extension, ".$codec")

    write-host $_.FullName

    &"$vlc" -I dummy "$oldFile" ":sout=#transcode{acodec=$codec,vcodec=dummy}:standard{access=file,mux=raw,dst='\$newFile'}"  vlc://quit | out-null

    if($isRemoveOldFile){
      Remove-Item $oldFile;
    }
}

function ConvertAllToMp3([string] $sourcePath, [switch] $isRemoveOldFile = $false) {  
  # write-host $sourcePath
  Get-ChildItem "$sourcePath\*" -include *.mp4 | ForEach-Object { ConvertToMp3 $_ $isRemoveOldFile}
}
 
ConvertAllToMp3 .