$metric_storage_service_ip = (Get-Content "C:\telegraf_ip.txt"|out-string).TrimEnd("`r`n")
$instanceid = Invoke-WebRequest "http://169.254.169.254/latest/meta-data/instance-id" -UseBasicParsing | Select-Object -ExpandProperty Content
$TelegrafConfPath = "C:\Program Files (x86)\AWC\telegrafa\telegraf_windows.conf"
(Get-Content $TelegrafConfPath | out-string).Replace("saas_node_id", $instanceid) | Set-Content $TelegrafConfPath
(Get-Content $TelegrafConfPath | out-string).Replace("metric_storage_service_ip", $metric_storage_service_ip) | Set-Content $TelegrafConfPath
Restart-Service TelegrafA
