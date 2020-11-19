# 1..6 | ForEach-Object {
#     $a = $_
#     1..2 | ForEach-Object {
#         if($a -eq 5 -and $_ -eq 1) {return}
#         "$a $_"
#     }
#     "---"
# }
# exit

# $i = 1
# while ($i -le 3) {
#     # Write-Output 'i aussen: ' $i
#     inn 
#     $j = 1
#     while ($j -le 4) {
#         Write-Output "i: $i ,j:  $j"
#         if ($j -eq 3) {
#             # break inn
#             # continue inn
#             return
#         }
#         $j++
#     }
#     $i++
# }
# exit

$dat = '.\angular.md'
$count = 1
$datstr = ''
[System.Collections.ArrayList]$al = @()
Get-Content $dat | ForEach-Object {
    $a = $_
    # $datstr = $line
    # :inn
    if ($a -match '-') {
        Write-Output '-['
        Get-Content $dat | ForEach-Object {
            $al.add( $_)
            if ($_ -match '##') {
                return
            }
        }
    }

    if ($count -eq 4) {
        break
    }
    $count++
}
Write-Output $al
