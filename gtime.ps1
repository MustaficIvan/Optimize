#Global Variables
$global:Process = Get-Process | Format-Table -Property Name;
$global:Obsticales = Get-Content .\processes.txt;


function Startup(){
  $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription];
  $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'));
  $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'));
  $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&All'));

  $OptionalProcess = [System.Collections.ArrayList]@();
  $OptionalFile = Get-Content .\optionalProcess.txt; 
  
  foreach($item in $OptionalFile){ $OptionalProcess.Add($item -split ','); }

  :process foreach($process in $OptionalProcess){
    $decision = $Host.UI.PromptForChoice($process[0].ToUpper(), 'Close '+ $process[0] +'?', $choices, 0);
    switch($decision){
      0{ break; }
      1{
        for($l = 1; $l -lt $OptionalProcess[$i].Count; $l++){ $global:Obsticales += $process[$l]; }
        break;
       } 
      2{
        foreach($obsticle in $OptionalProcess){ for($j = 1; $j -lt $obsticle.Count; $j++){ $global:Obsticales += $obsticle[$j]; }}
        break process;
       }
    }
    $i++;
  }
}

function KillProcess(){
  foreach($process in $global:Obsticales){ Stop-Process -Name $process -Force; }
}

#MAIN
function Main(){
  Startup;
  KillProcess;
}
Main;
