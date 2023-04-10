// import 'Dart:io';

// // Future runwinnot({String ptname, phone, docname, date, time, towait}) async {
// //   // String line1 = r'';
// //   await Process.run(
// //       'powershell.exe',
// //       [
// //         r'Add-Type -AssemblyName System.Windows.Forms'
// //             '\n'
// //             r'$global:balloon = New-Object System.Windows.Forms.NotifyIcon'
// //             '\n'
// //             r'$path = (Get-Process -id $pid).Path'
// //             '\n'
// //             r'$balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)'
// //             '\n'
// //             r'$balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning'
// //             '\n'
// //             r'$balloon.BalloonTipText = "What do you think of this balloon tip?"'
// //             '\n'
// //             r'$balloon.BalloonTipTitle = "Attention $Env:USERNAME"'
// //             '\n'
// //             r'$balloon.Visible = $true'
// //             '\n'
// //             r'Start-Sleep -s 20'
// //             '\n'
// //             r'$balloon.ShowBalloonTip(15000)'
// //       ],
// //       includeParentEnvironment: true);
// // }

// Future runwinnot(
//     {required String ptname, phone, docname, date, time, towait}) async {
//   String line1 = r'Add-Type -AssemblyName System.Windows.Forms';
//   String line2 =
//       r'$global:balloon = New-Object System.Windows.Forms.NotifyIcon';
//   String line3 = r'$path = (Get-Process -id $pid).Path';
//   String line4 =
//       r'$balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)';
//   String line5 =
//       r'$balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning';
//   String line6 = r'$balloon.BalloonTipText =';
//   String line7 = r'$balloon.BalloonTipTitle = "Call Patient Notification"';
//   String line8 = r'$balloon.Visible = $true';
//   String line9 = r'Start-Sleep -s';
//   String line10 = r'$balloon.ShowBalloonTip(15000)';
//   await Process.start(
//       'powershell.exe',
//       [
//         '$line1'
//             '\n'
//             '$line2'
//             '\n'
//             '$line3'
//             '\n'
//             '$line4'
//             '\n'
//             '$line5'
//             '\n'
//             '$line6 Name : $ptname, Phone : $phone, Doctor : $docname, Date : $date, Time : $time'
//             '\n'
//             '$line7'
//             '\n'
//             '$line8'
//             '\n'
//             '$line9 $towait'
//             '\n'
//             '$line10'
//       ],
//       includeParentEnvironment: true,
//       mode: ProcessStartMode.detached);
// }

// Future runwinnotwithoutsleep(
//     {required String ptname, phone, docname, date, time, towait}) async {
//   String line1 = r'Add-Type -AssemblyName System.Windows.Forms';
//   String line2 =
//       r'$global:balloon = New-Object System.Windows.Forms.NotifyIcon';
//   String line3 = r'$path = (Get-Process -id $pid).Path';
//   String line4 =
//       r'$balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)';
//   String line5 =
//       r'$balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning';
//   String line6 = r'$balloon.BalloonTipText =';
//   String line7 = r'$balloon.BalloonTipTitle = "Call Patient Notification"';
//   String line8 = r'$balloon.Visible = $true';
//   // String line9 = r'Start-Sleep -s';
//   String line10 = r'$balloon.ShowBalloonTip(15000)';
//   await Process.start(
//       'powershell.exe',
//       [
//         '$line1'
//             '\n'
//             '$line2'
//             '\n'
//             '$line3'
//             '\n'
//             '$line4'
//             '\n'
//             '$line5'
//             '\n'
//             '$line6 Name : $ptname, Phone : $phone, Doctor : $docname, Date : $date, Time : $time'
//             '\n'
//             '$line7'
//             '\n'
//             '$line8'
//             '\n'
//             // '$line9 $towait'
//             // '\n'
//             '$line10'
//       ],
//       includeParentEnvironment: true,
//       mode: ProcessStartMode.detached);
// }
