# Windows PowerShell Script for organizing music
# Assumes that your songs are named in the "Artist - Song.mp3" format
# Creates folders to organize music based on first character of artist name and Subsequent Artist folders
# To run this script you must allow your system to do so by typing "Set-ExecutionPolicy RemoteSigned" into windows powershell
# Must run the powershell as admin to do the Set-ExecutionPolicy Command


$currentDir = Get-Location
$currentDir = Get-ChildItem

echo "Organizing Your Music"

foreach ($file in $currentDir)
{
    if ( $file.Extension -eq ".mp3" )
    {
        $song = $file.BaseName
        $dirName = $song.SubString(0,1);
        if([Regex]::IsMatch( $dirName, "[0-9]" ))
        {
            $dirName = "#"
        }
        if ( (Test-Path -path $dirName) -ne $True )
        {
            mkdir $dirName
        }
        
        mv $file $dirName/   
    }

} 

$musicDir = Get-Location
$currentDir = Get-Location
$currentDir = Get-ChildItem

foreach ($folder in $currentDir)
{
    cd $folder
    $folder = Get-ChildItem
    foreach ($mp3 in $folder)
    {
        if ( $mp3.Extension -eq ".mp3" )
        {
            $song = $mp3.BaseName
            $artistDir = $song.SubString(0, $song.indexOf("-")-1);

            if ( (Test-Path -path $artistDir) -ne $True )
            {
                mkdir $artistDir
            }
        
            mv $mp3 $artistDir/   
        }
    }
    cd $musicDir
} 

echo Done


