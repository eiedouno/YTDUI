Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# Create main window
$Window = New-Object System.Windows.Window
$Window.Title = "YTDUI - YouTube Downloader, YT-DLP"
$Window.Height = 800
$Window.Width = 650
$Window.WindowStartupLocation = "CenterScreen"

# Add ScrollViewer for many options
$ScrollViewer = New-Object Windows.Controls.ScrollViewer
$ScrollViewer.VerticalScrollBarVisibility = "Auto"
$StackPanel = New-Object Windows.Controls.StackPanel
$StackPanel.Margin = '10'
$ScrollViewer.Content = $StackPanel

# ===== Header =====
$headerLabel = New-Object Windows.Controls.Label
$headerLabel.Content = "YouTube Downloader - YT-DLP"
$headerLabel.FontSize = 20
$headerLabel.Foreground = [Windows.Media.Brushes]::DarkBlue
$headerLabel.FontWeight = "Bold"
$headerLabel.HorizontalAlignment = "Center"
$headerLabel.Margin = '0,0,0,20'
$StackPanel.Children.Add($headerLabel)

$sectionLabel_Video = New-Object Windows.Controls.Label
$sectionLabel_Video.Content = "Video Options:"
$sectionLabel_Video.Margin = '20'
$sectionLabel_Video.FontWeight = "Bold"
$sectionLabel_Video.FontSize = 14
$sectionLabel_Video.Foreground = [Windows.Media.Brushes]::DarkBlue
$StackPanel.Children.Add($sectionLabel_Video)

# ===== Video URL =====
$labelUrl = New-Object Windows.Controls.Label
$labelUrl.Content = "YouTube URL:"
$StackPanel.Children.Add($labelUrl)

# === URL Input SP ===
$StackPanelUrl = New-Object Windows.Controls.StackPanel
$StackPanelUrl.Orientation = "Horizontal"
$StackPanel.Children.Add($StackPanelUrl)

$textUrl = New-Object Windows.Controls.TextBox
$textUrl.Width = 240
$textUrl.Height = 20
$textUrl.HorizontalAlignment = "Left"
$StackPanelUrl.Children.Add($textUrl)

$urlPaste = New-Object Windows.Controls.Button
$urlPaste.Content = "Paste"
$urlPaste.Margin = '5'
$urlPaste.HorizontalAlignment = "Right"
$urlPaste.Width = 40
$urlPaste.Height = 20
$StackPanelUrl.Children.Add($urlPaste)

# ===== Download Button =====
$btnDownload = New-Object Windows.Controls.Button
$btnDownload.Content = "Download"
$btnDownload.Width = 100
$btnDownload.Height = 40
$btnDownload.Margin = "190,0,0,0"
$btnDownload.HorizontalAlignment = "Right"
$StackPanelUrl.Children.Add($btnDownload)

# ===== Audio Options =====
$checkAudioOnly = New-Object Windows.Controls.CheckBox
$checkAudioOnly.Content = "Audio Only"
$checkAudioOnly.Margin = '10'
$StackPanel.Children.Add($checkAudioOnly)

$labelAudioFmt = New-Object Windows.Controls.Label
$labelAudioFmt.Content = "Audio Format:"
$labelAudioFmt.Margin = "0,10,0,0"
$labelAudioFmt.Visibility = "Collapsed"
$StackPanel.Children.Add($labelAudioFmt)

$comboAudioFmt = New-Object Windows.Controls.ComboBox
$audioFormats = @("mp3","m4a","opus","flac","wav")
foreach ($fmt in $audioFormats) { $comboAudioFmt.Items.Add($fmt) }
$comboAudioFmt.SelectedIndex = 0
$comboAudioFmt.Margin = '0,0,0,10'
$comboAudioFmt.Visibility = "Collapsed"
$StackPanel.Children.Add($comboAudioFmt)

$labelAudioQ = New-Object Windows.Controls.Label
$labelAudioQ.Content = "Audio Quality (0=best):"
$labelAudioQ.Margin = "0,10,0,0"
$labelAudioQ.Visibility = "Collapsed"
$StackPanel.Children.Add($labelAudioQ)

$comboAudioQ = New-Object Windows.Controls.ComboBox
0..9 | ForEach-Object { $comboAudioQ.Items.Add($_) }
$comboAudioQ.SelectedIndex = 0
$comboAudioQ.Margin = '0,0,0,10'
$comboAudioQ.Visibility = "Collapsed"
$comboAudioQ.ToolTip = "0=best, 9=worst"
$StackPanel.Children.Add($comboAudioQ)

# ===== Video Format Options =====
$labelVideoFmt = New-Object Windows.Controls.Label
$labelVideoFmt.Content = "Video Format:"
$labelVideoFmt.Margin = "0,10,0,0"
$StackPanel.Children.Add($labelVideoFmt)

$comboVideoFmt = New-Object Windows.Controls.ComboBox
$videoFormats = @( 
    "Higest Quality",
    "Highest Quality (mp4)",
    "1080p",
    "720p",
    "Best Video + Best m4a Audio",
    "Best Video (VP9) + Best Audio (Opus) (WebM Default)",
    "Best Video (AV1) + Best Audio (Opus) (WebM)",
    "Best Video (AVC) + Best Audio",
    "480p",
    "Lowest File Size"
)
foreach ($vf in $videoFormats) { $comboVideoFmt.Items.Add($vf) }
$comboVideoFmt.SelectedIndex = 0
$comboVideoFmt.Margin = '0,0,0,10'
$StackPanel.Children.Add($comboVideoFmt)

# ===== Title and Output Location =====
$labelTitle = New-Object Windows.Controls.Label
$labelTitle.Content = "Custom Video Title:"
$labelTitle.Margin = '0,10,0,0'
$StackPanel.Children.Add($labelTitle)

$textTitle = New-Object Windows.Controls.TextBox
$textTitle.Width = 600
$textTitle.Margin = '0,0,0,10'
$StackPanel.Children.Add($textTitle)

$labelOutputLocation = New-Object Windows.Controls.Label
$labelOutputLocation.Content = "Output Location:"
$labelOutputLocation.Margin = '0,10,0,0'
$StackPanel.Children.Add($labelOutputLocation)

$textOutputLocation = New-Object Windows.Controls.TextBox
$textOutputLocation.Width = 600
$textOutputLocation.Text = "$($env:USERPROFILE)\YouTubeDownloads\"  # Default output location
$textOutputLocation.Margin = '0,0,0,10'
$StackPanel.Children.Add($textOutputLocation)

# ===== Embedding Options =====
$checkThumb = New-Object Windows.Controls.CheckBox
$checkThumb.Content = "Embed Thumbnail"
$checkThumb.Margin = '10'
$StackPanel.Children.Add($checkThumb)

$checkMeta = New-Object Windows.Controls.CheckBox
$checkMeta.Content = "Embed Metadata"
$checkMeta.Margin = '10'
$StackPanel.Children.Add($checkMeta)

$checkEmbedSubs = New-Object Windows.Controls.CheckBox
$checkEmbedSubs.Content = "Embed Subtitles"
$checkEmbedSubs.Margin = '10'
$StackPanel.Children.Add($checkEmbedSubs)

$checkWriteSubs = New-Object Windows.Controls.CheckBox
$checkWriteSubs.Content = "Download Subtitles (Use Youtube in-video subtitles)"
$checkWriteSubs.Margin = '10'
$StackPanel.Children.Add($checkWriteSubs)

# ===== Debug Options =====

$sectionLabel_AO = New-Object Windows.Controls.Label
$sectionLabel_AO.Content = "Debug:"
$sectionLabel_AO.Margin = '20'
$sectionLabel_AO.FontWeight = "Bold"
$sectionLabel_AO.Foreground = [Windows.Media.Brushes]::DarkRED
$StackPanel.Children.Add($sectionLabel_AO)

$checkSimulate = New-Object Windows.Controls.CheckBox
$checkSimulate.Content = "Simulate Only"
$checkSimulate.ToolTip = "Simulate download without actually downloading"
$checkSimulate.Margin = '10'
$StackPanel.Children.Add($checkSimulate)

$keepFiles = New-Object Windows.Controls.CheckBox
$keepFiles.Content = "Keep Files"
$keepFiles.ToolTip = "Keep temporary files after download"
$keepFiles.Margin = '10'
$StackPanel.Children.Add($keepFiles)

### ===== Component Logic =====

# === Paste URL ===
$urlPaste.Add_Click({
    $textUrl.Text = Get-Clipboard
})

# === Audio Check ===
$checkAudioOnly.Add_Checked({
    $comboAudioFmt.Visibility = "Visible"
    $labelAudioFmt.Visibility = "Visible"
    $labelAudioQ.Visibility = "Visible"
    $comboAudioQ.Visibility = "Visible"
    $comboVideoFmt.Visibility = "Collapsed"
    $labelVideoFmt.Visibility = "Collapsed"
    $sectionLabel_Video.Content = "Audio Options:"
    $sectionLabel_Video.Foreground = [Windows.Media.Brushes]::DarkGreen
    $headerLabel.Foreground = [Windows.Media.Brushes]::DarkGreen
})
$checkAudioOnly.Add_Unchecked({
    $comboAudioFmt.Visibility = "Collapsed"
    $labelAudioFmt.Visibility = "Collapsed"
    $labelAudioQ.Visibility = "Collapsed"
    $comboAudioQ.Visibility = "Collapsed"
    $comboVideoFmt.Visibility = "Visible"
    $labelVideoFmt.Visibility = "Visible"
    $sectionLabel_Video.Content = "Video Options:"
    $sectionLabel_Video.Foreground = [Windows.Media.Brushes]::DarkBlue
    $headerLabel.Foreground = [Windows.Media.Brushes]::DarkBlue
})

# === Download Button ===
$btnDownload.Add_Click({
    $url = $textUrl.Text
    $outputLocation = $textOutputLocation.Text
    $title = $textTitle.Text
    $audioOnly = $checkAudioOnly.IsChecked
    $audioFormat = $comboAudioFmt.SelectedItem
    $audioQuality = $comboAudioQ.SelectedItem
    $videoFormat = $comboVideoFmt.SelectedIndex
    $embedThumb = $checkThumb.IsChecked
    $embedMeta = $checkMeta.IsChecked
    $embedSubs = $checkEmbedSubs.IsChecked
    $writeSubs = $checkWriteSubs.IsChecked
    $simulateOnly = $checkSimulate.IsChecked
    $keepFiles = $keepFiles.IsChecked

    # Format variables
    if (Test-Path $outputLocation) {
        $outputLocation = $outputLocation.TrimEnd('\')
    } else {
        Write-Host "Output location does not exist. Please create the directory."
        [System.Windows.MessageBox]::Show("Output location does not exist. Please create the directory.", "Error", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
        return
    }
    if ($title -eq "") {
        $title = '%(title)s'
    }
    $outputLocation = "$outputLocation\$title"
    $outputLocation += '.%(ext)s'
    if ($audioOnly) {
        $audioFormat = $audioFormat.ToLower()
        $audioQuality = $audioQuality.ToString()
    }
    switch ($videoFormat) {
        0 { $videoFormat = "bestvideo+bestaudio/best" }
        1 { $videoFormat = "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]" }
        2 { $videoFormat = "bestvideo[height<=1080]+bestaudio" }
        3 { $videoFormat = "bestvideo[height<=720]+bestaudio" }
        4 { $videoFormat = "bv*+ba[acodec^=mp4a]/b[ext=mp4]/b" }
        5 { $videoFormat = "bestvideo[vcodec=vp9]+bestaudio[acodec=opus]" }
        6 { $videoFormat = "bestvideo[vcodec=av01]+bestaudio[acodec=opus]" }
        7 { $videoFormat = "bestvideo[vcodec^=avc1]+bestaudio" }
        8 { $videoFormat = "bestvideo[height<=480]+bestaudio" }
        9 { $videoFormat = "worstvideo+worstaudio/worst" }
    }

        # Build command
        $cmd = "yt-dlp.exe"
        if ($audioOnly) {
            $cmd += " -x --audio-format $audioFormat --audio-quality $audioQuality"
        } else {
            $cmd += " -f $videoFormat"
        }
        if ($embedThumb) { $cmd += " --embed-thumbnail" }
        if ($embedMeta) { $cmd += " --embed-metadata" }
        if ($embedSubs) { $cmd += " --embed-subs" }
        if ($writeSubs) { $cmd += " --write-subs" }
        if ($simulateOnly) { $cmd += " --simulate" }
        if ($keepFiles) { $cmd += " -k" }
    
        # Wrap output template and URL in single quotes to prevent PowerShell expansion
        $cmd += " -o $outputLocation $url"
    
        # Execute command directly
        Write-Host "Executing: $cmd"
        Start-Process -FilePath "yt-dlp.exe" `
                      -ArgumentList (($cmd -replace '^yt-dlp.exe ', '').Split(' ')) `
                      -NoNewWindow -Wait

})
# Set content and show
$Window.Content = $ScrollViewer
$Window.ShowDialog()
exit