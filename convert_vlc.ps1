function ConvertToMp3 ($inputo, [switch]$isRemoveOldFile = $false) {
  $codec = 'mp3'
  $alt = $inputo

  # $newFile = $_.FullName.Replace(' ', '').Replace($_.Extension, ".$codec")
  # $neu=$newFile.substring(0,5)
  $neu = [System.IO.Path]::GetFileNameWithoutExtension($inputo).replace(' ', '').substring(0, 10)
  $pfad = Split-Path -path $alt
  write-host "$neu.mp3 -- $alt -- $pfad" 
  
  vlc -I dummy "$alt" ":sout=#transcode{acodec=$codec,vcodec=dummy}:standard{access=file,mux=raw,dst=$pfad/$neu.mp3}"  vlc://quit | out-null
  
  if ($isRemoveOldFile) {
    Remove-Item $alt
  }
}

function ConvertAllToMp3([string] $sourcePath, [switch] $isRemoveOldFile = $false) {  
  $sp = Get-ChildItem "$sourcePath\*"
  # write-host quelle $sp
  Get-ChildItem $sourcePath/* -include *.mp4 | ForEach-Object { ConvertToMp3 $_ $isRemoveOldFile }
}
 
# ConvertAllToMp3 .
# vlc -I dummy .\fonsi.mp4 ":sout=#transcode{acodec=mp3,vcodec=dummy}:standard{access=file,mux=raw,dst=fonsi.mp3}"  vlc://quit | out-null
