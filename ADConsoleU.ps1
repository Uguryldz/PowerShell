#Bu Script Uğur Yıldız tarafından  yazılmıştır..
mkdir c:\temp\
${version}="1.0"
${CreatedBy}="Uğur YILDIZ"
${LastModifiedBy}=$CreatedBy
$PSVer= Get-Host | Select-Object Version
cls
cls
#Main Menu
Function menu{
cls
Write-host "PowerShell : ${PSVer}"  -foregroundcolor green
write-output "" ""
write-output "   __  __________  ______     __  ________    ____  _________"
write-output "  / / / / ____/ / / / __ \    \ \/ /  _/ /   / __ \/  _/__  /"
write-output " / / / / / __/ / / / /_/ /     \  // // /   / / / // /   / / "
write-output "/ /_/ / /_/ / /_/ / _, _/      / // // /___/ /_/ // /   / /__"
write-output "\____/\____/\____/_/ |_|      /_/___/_____/_____/___/  /____/"
write-output "                                                             "
write-output "" ""
Write-host "             " "Hızlı Power Shell Active Directory İşlemleri ${version} "  -foregroundcolor green
Write-host "                                                           " " CreatedBy : ${CreatedBy}"  -foregroundcolor green
write-output "" ""
write-output "Menüde Kullandığım Kısaltmalar"
write-output "PS PowerShell" "AD: Active Directory" "OU: Organization Unit" "GPO: Group Policy" ""
Write-Warning "Yukarıda Yazdığım Kısaltmaları Bil İşlemleri menüyü okuyarak yaparsan patlamayızzz.. :))"
write-output "" ""
Write-host "!!! Scripti Yönetici Olarak Çalıştır.. Patlamayalım sonra.. !!!" -ForegroundColor White -BackgroundColor red
write-output "" ""
#Main Menu Aciklama 
Write-host "1. PS Remoting İşlemleri" -ForegroundColor  white -BackgroundColor black
Write-host "2. PS AD Kullanıcı İşlemleri" -ForegroundColor  white -BackgroundColor black
Write-host "3. PS AD Grup İşlemleri" -ForegroundColor  white -BackgroundColor black
Write-host "4. PS AD Bilgisayar İşlemleri" -ForegroundColor  white -BackgroundColor black
Write-host "5. PS Windows Server Client İşlemleri (Backup-CopyFile-GPUpdate vs)" -ForegroundColor  white -BackgroundColor black
Write-host "8. Modül ve Özellik Yüklemeleri " -ForegroundColor  green -BackgroundColor black
Write-host "9. PS Raporlama ve Rapor Export İşlemleri" -ForegroundColor  green -BackgroundColor black
Write-host "C. Çıkış" -ForegroundColor White -BackgroundColor red
write-output "" 
$menulistenumarasi = read-host "Menüden Yapmak İstediğiniz İşlemin Numarasını Giriniz" 
switch ($menulistenumarasi)
{
#PSRemoting

 1 { 
    cls
    write-output "" ""
    Function PSmenu{
    Write-host "1. PS Remoting İnstall Enable"  
    Write-host "2. PS Remoting Connect PS"
    Write-host "3. Makina Ping Kontrol"
    Write-host "M. Ana Menüye Dön" -ForegroundColor White -BackgroundColor red
    write-output "" 
    $PSmenulistenumarasi = read-host "Menüden Yapmak İstediğiniz İşlemin Numarasını Giriniz" 
    switch ($PSmenulistenumarasi)
    {
    #PS Remoting İnstall
     1 {
    cls
    Enable-PSRemoting –force
    Set-Service WinRM -StartMode Automatic
    Enable-PSRemoting -SkipNetworkProfileCheck 
    write-output "PS Remoting Yüklendi"
    PSmenu }

     #PS Remoting Connect PS
     2 {
     cls
     write-output "" ""
     $CompIPName= Read-Host "Bağlanmak istediğiniz bilgisar adı yada ip adresini giriniz.."
     enter-PSSession -ComputerName $CompIPName  -Credential (Get-Credential)   
     powershell
     }
    #PSExec Connect PS
     3 {
     cls
     write-output "" ""
     $CompControl= Read-Host "Pinglemek istediğiniz makina adı ip adresi.."
     ping $CompControl
     PSmenu
     }
    #MENU
     M { Menu }
    }
    }
    PSMenu
   }
      #PSMenu

#PS AD USER
 2 {
    cls
    write-output "" ""
    Function Umenu{
    Write-host "1. Kullanıcı username göre arama"  
    Write-host "2. Kullanıcı ismine göre arama"
    Write-host "Aşağıdaki tüm işlemler için username'i bilmeniz gerekir.."  -ForegroundColor White -BackgroundColor red
    Write-host "3. Kullanıcı Şifresi Resetleme"
    Write-host "4. Kullanıcı Hesabını Etkinleştir"
    Write-host "5. Kullanıcı Hesabını Devre Dışı Bırak"
    Write-host "6. Kullanıcı Hesabının Kilidini Aç"
    Write-host "7. Sonraki Girişte Şifre Değişikliğini Zorla"
    Write-host "8. Tek Bir Kullanıcının Tüm Bilgilerini Görme"
    Write-host "9. Tek Bir Kullanıcının Temel Bilgilerini Görme (Name,Department,Title,Manager,DisplayName,TelephoneNumber,Mail,MemberOf)"
    Write-host "M. Ana Menüye Dön" -ForegroundColor White -BackgroundColor red
    write-output "" 
    $Umenulistenumarasi = read-host "Menüden Yapmak İstediğiniz İşlemin Numarasını Giriniz" 
    switch ($Umenulistenumarasi)
    {
    
     1 {
     cls
     write-output "" ""
     $Adusersearch= Read-Host "Aramak istediğiniz username giriniz.."
     $filter="SamAccountName -like ""*$Adusersearch*"""
     get-Aduser -Filter  $filter  
     pause
     cls
     menu 
       }
     #
     2 {
     cls
     write-output "" ""
     $Adnamersearch= Read-Host "Aramak istediğiniz kullanıcı ismini giriniz.."
     $filter="Name -like ""*$Adusersearch*"""
     get-Aduser -Filter $filter
     pause
     menu 
       }
     #
     3 {
     cls
     write-output "" ""
     $AdPassName= Read-Host "Şifresini Resetlemek İstediğiniz KullanıcıAdını giriniz.."
     $AdPassRes= Read-Host "Vermek istediğiniz yeni şifreyi giriniz.."
     cls
     Set-ADAccountPassword -Identity $AdPassName -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $AdPassRes -Force)
     write-output "" ""
     Write-host "'$AdPassName' kullanıcısının şifresi '$AdPassRes' olarak değiştirilmiştir.." -ForegroundColor White -BackgroundColor black
     write-output "Fare ile şifre alanını seçip(markedip) enter tuşuna basarak şifreyi kopyalayabilirsiniz.."
     write-output "Şifreyi kopyaladıysan iki defa boşluk tuşuna basıp menüye dönebilirsin.."
     pause
     pause
     CLS
     Umenu
       }
     #
     4 {
     cls
     write-output "" ""
     $AdUserActive= Read-Host "Hesabını Etkinleştirmek İstediğiniz Kullanıcıadını giriniz.."
     Enable-ADAccount -Identity $AdUserActive
     Add-Type -AssemblyName PresentationCore,PresentationFramework
     Write-host "'$AdUserActive' Kullanıcısı Etkinleştirilmiştir.." -ForegroundColor White -BackgroundColor red
     CLS
     Umenu
        }
     #
     5 {
     cls
     write-output "" ""
     $AdUserPassive= Read-Host "Hesabını Devradışı bırakmak İstediğiniz Kullanıcıadını giriniz.."
     Disable-ADAccount -Identity $AdUserPassive
     Write-host "'$AdUserPassive' Kullanıcısı Devredışı bırakılmıştır.." -ForegroundColor White -BackgroundColor red
     pause
     CLS
     Umenu
        }
     #
     6 {
     cls
     write-output "" ""
     $AdUserUnLock= Read-Host "Hesap kilidini kaldırmak İstediğiniz Kullanıcıadını giriniz.."
     Unlock-ADAccount –Identity $AdUserUnLock
     Add-Type -AssemblyName PresentationCore,PresentationFramework
     Write-host "'$AdUserUnLock' Kullanıcısının kilidi kaldırılmıştır.." -ForegroundColor White -BackgroundColor red
     pause
     CLS
     Umenu
       }
     #
     7 {
     cls
     write-output "" ""
     $AdUserClogon= Read-Host "Sonraki Girişte Şifre Değişikliği Yapmasını İstediğiniz Username'i giriniz.."
     Set-ADUser -Identity $AdUserClogon -ChangePasswordAtLogon $true
     Write-host "'$AdUserClogon' Kullanıcısı bir sonraki girişinde şifresini değiştirmek zorundadır.." -ForegroundColor White -BackgroundColor red
     pause
     CLS
     Umenu
       }
     #
     8 {
     cls
     write-output "" ""
     $AdUserPropF= Read-Host "Bilgilerini görmek İstediğiniz Username'i giriniz.."
     Get-ADUser -Identity  $AdUserPropF -Properties *
     pause
     CLS
     Umenu
       }
     #
     9 {
     cls
     write-output "" ""
     $AdUserProp= Read-Host "Bilgilerini görmek İstediğiniz Username'i giriniz.."
     Get-ADUser -Identity  $AdUserProp -Properties Name,Department,Title,Manager,DisplayName,TelephoneNumber,Mail,MemberOf
     pause
     CLS
     Umenu
       }

    #MENU
     M { Menu }
    }
    }
    Umenu
      
 
  #PS AD USER
 
 }
        #ADUMenu
#PS AD Group
 3 {
    cls
    write-output "" ""
    Function Gmenu{
    Write-host "1. Grup Adına Göre Arama"  
    Write-host "Aşağıdaki tüm işlemler için GrupAdını bilmeniz gerekir.."  -ForegroundColor White -BackgroundColor red
    Write-host "2. Grubun Kullanıcı Listesini Çek"
    Write-host "3. Gruba Kullanı Ekle"
    Write-host "M. Ana Menüye Dön" -ForegroundColor White -BackgroundColor red
    write-output "" 
    $Gmenulistenumarasi = read-host "Menüden Yapmak İstediğiniz İşlemin Numarasını Giriniz" 
    switch ($Gmenulistenumarasi)
    {
    #
     1 {
      cls
     write-output "" ""
     $AdGnamersearch= Read-Host "Aramak İstediğiniz Grup Adını Giriniz Grubu Tüm Özellikleri İle Getirir.."
     get-adgroup -properties *  -filter * | Where-Object {$_.name -like "*$AdGnamersearch*"}
     pause
     cls
     Gmenu
       }
       #
     2 {
     cls
     write-output "" ""
     $AdGUList= Read-Host "Kullanıcı Listesi Alınacak Grup Adını Giriniz.."
     Get-ADGroupMember -identity "$AdGUList"
     pause
     cls
     Gmenu
       }
       #
     3 {
     cls
     write-output "" ""
     $AdGName= Read-Host "Ekleme Yapmak İstediğiniz Grup Adını Giriniz.."
     Write-host "Birden Fazla Kullanıcı Var İse ',' İle Ayırarak Yazabilirsiniz User1,User2,User3......" -ForegroundColor White -BackgroundColor red
     $AdGUAdd= Read-Host "Eklemek İstediğiniz Kullanıcı Adını Yazınız"
     cls
     Write-host "'$AdGName' Grubuna '$AdGUAdd' Kullanıcıları Eklenmiştir.."  -ForegroundColor White -BackgroundColor red
     pause
     cls
     Gmenu
      }
        #MENU
     M { Menu }
    }
    }
    Gmenu
    }
        #ADGMenu
#PS AD PC
 4 {
    cls
    write-output "" ""
    Function PCmenu{
    Write-host "1. Bilgisayar Adına Göre Arama"  
    Write-host "Aşağıdaki tüm işlemler için Bilgisayar Adını bilmeniz gerekir.."  -ForegroundColor White -BackgroundColor red
    Write-host "2. Bilgisayar Sil"
    Write-host "3. OU'dan Tüm Bilgisayar Sil" -ForegroundColor White -BackgroundColor red
    Write-host "M. Ana Menüye Dön" -ForegroundColor White -BackgroundColor red
    write-output "" 
    $PCmenulistenumarasi = read-host "Menüden Yapmak İstediğiniz İşlemin Numarasını Giriniz" 
    switch ($PCmenulistenumarasi)
    {
    #
     1 {
      cls
     write-output "" ""
     $AdPCNsearch= Read-Host "Aramak İstediğiniz Grup Adını Giriniz Grubu Tüm Özellikleri İle Getirir.."
     Get-AdComputer -filter *| Where-Object {$_.name -like "*$AdPCNsearch*"}
     pause
     cls
     PCmenu
       }
       #
     2 {
     cls
     write-output "" ""
     $AdPCDel= Read-Host "Silinecek Bilgisayar Adını Giriniz"
     Remove-ADComputer -Identity "$AdPCDel"
     Write-host "'$AdPCDel' adlı Bilgisayar Silinmiştir.."   -ForegroundColor White -BackgroundColor red
     pause
     cls
     PCmenu
       }
       #
     3 {
     cls
     write-output "" ""
     Write-host "Bu İşlemi Geri Alamayız Aslan OU içindeki Tüm Bilgisayarları Silcez Bak Eminsen Enter Yap Devam Et.."  -ForegroundColor White -BackgroundColor red
     Pause
     $AdOUPCNAME= Read-Host "Bilgisayarın Silineceği OU'yu Yazınız.."
     Get-ADComputer -SearchBase "OU=IT" -Filter * | Remove-ADComputer
     Write-host "'$AdOUPCNAME' OU'sundaki Tüm Bilgisayarları Sildim Valla Geçmiş Olsun.."   -ForegroundColor White -BackgroundColor red
     pause
     cls
     PCmenu
     }
        #MENU
     M { Menu }
    }
    }
    PCmenu
    }
#PSWinSRVClient
 5 {    cls
    write-output "" ""
    Function WSCmenu{
    Write-host "Remote Command" -ForegroundColor White -BackgroundColor red
    Write-host "1. Uzak PC Restart.. Birkaç Dk Sürer" 
    Write-host "2. Dosyaları ve Klasörleri Kopyala.." 
    Write-host "3. Uzak Dosya Çalıştır"
    Write-host "4. GPUpdate Gönder"
    Write-host "Backup" -ForegroundColor White -BackgroundColor red
    Write-host "8. Active Directory Sistem Durumunu Uzaktan Yedekleme.."  
    Write-host "9. Etki Alanındaki tüm GPO'ları yedekleyin.."    
    Write-host "M. Ana Menüye Dön" -ForegroundColor White -BackgroundColor red
    write-output "" 
    $WSCmenulistenumarasi = read-host "Menüden Yapmak İstediğiniz İşlemin Numarasını Giriniz" 
    switch ($WSCmenulistenumarasi)
    {
    #
     1 {
      cls
     write-output "" ""
     Write-host "Birden Fazla Bilgisayar Restart Edilecek İse ',' İle Ayırarak Yazabilirsiniz PCName1,PCIP1,PCName2......" -ForegroundColor White -BackgroundColor red
     $PCRESNI= Read-Host "Restart Etmek istediğiniz PCName Yada ip Adresini yazınız.."
     Restart-Computer -ComputerName $PCRESNI
     [System.Windows.MessageBox]::Show("Bilgisayarlar restart edilmiştir..")
     cls
     WSCmenu
       }
    #
     2 {
      cls
     write-output "" ""
     $CopyFilePath= Read-Host "Kopyalanacak Dosyanın yada Klasörün Path'ini Giriniz.. Örn: C:\dizin\test.bat.."
     $DespCopyFilePath= Read-Host "Hedef Bilgisayar Adını Giriniz.. Örn: C:\Temp\ Folder Altına Kopyalanacaktır.."
     copy-item $CopyFilePath -destination \\$DespCopyFilePath\Temp\ -recurse -verbose
     [System.Windows.MessageBox]::Show(" Dosya/Klasör \\$DespCopyFilePath\Temp\ altına kopyalanmıştır..")
     cls
     WSCmenu
       }
    #
     3 {
      cls
     write-output "" ""
     Write-host "Birden Fazla Bilgisayara Dosya Çalıştırılacak İse ',' İle Ayırarak Yazabilirsiniz PCName1,PCIP1,PCName2......" -ForegroundColor White -BackgroundColor red
     $StartFileC= Read-Host "Bilgisayar Adını Giriniz "
     $StartFileP= Read-Host "Çalıştırmak İstediğiniz Uzak Dosyanın Path'ini Giriniz Örn: C:\dizin\test.bat "
     Invoke-Command -FilePath $StartFileP -ComputerName $StartFileC  -Credential (Get-Credential)
     [System.Windows.MessageBox]::Show("İşlem Tamamlandı..")
     cls
     WSCmenu
       }
    #
     4 {
      cls
     write-output "" ""
     Write-host "Birden Fazla Bilgisayar GPUPDATE Edilecek İse ',' İle Ayırarak Yazabilirsiniz PCName1,PCIP1,PCName2......" -ForegroundColor White -BackgroundColor red
     $PCGPUpDate= Read-Host "GPUPDATE Göndermek istediğiniz PCName Yada ip Adresini yazınız.."
     Invoke-Command -ComputerName $PCGPUpDate -ScriptBlock {gpupdate /force}
     write-output "GPUpdate Yapıldı.." 
     pause
     cls
     WSCmenu
       }
    #
     8 {$ADCoName= Read-Host "Active Directory Sistem Durumunu Yedeklenecek Server Adını Giriniz "
     invoke-command -ComputerName $ADCoName -scriptblock {wbadmin start systemstateback up -backupTarget:"c:\temp\ADBackup" -quiet} -Credential (Get-Credential)
         [System.Windows.MessageBox]::Show("'c:\temp\ADBackup'PS Dizinine Alınmıştır..") }
     #
     9 { Backup-Gpo -All -Path c:\temp\GPObackup 
         [System.Windows.MessageBox]::Show("GPObackup PS Dizinine Alınmıştır..")
             }
    #MENU
     M { Menu }
    }
    }
    WSCmenu


    }
#PSInstall
 8 {cls
    write-output "" ""
    Function IMmenu{
    Write-host "1. Enable Telnet.."  
    Write-host "M. Ana Menüye Dön" -ForegroundColor White -BackgroundColor red
    write-output "" 
    $IMmenulistenumarasi = read-host "Menüden Yapmak İstediğiniz İşlemin Numarasını Giriniz" 
    switch ($IMmenulistenumarasi)
    {
    #
     1 {
      cls
     write-output "" ""
     Install-WindowsFeature Telnet-Client
     write-output "Telnet Yüklenmiştir.."
     cls
     IMmenu
       }
    #MENU
     M { Menu }
    }
    }
    IMmenu
}
#PSReport
 9 { cls
    write-output "" ""
    Function Rmenu{
    Write-host "Aşağıdaki Raporlar PowerShell Scriptin Çalıştığı Dizine Otomatik Oluşacaktır.."  -ForegroundColor White -BackgroundColor red 
    Write-host "1. Tüm AD Kullanıcılarını Ada Göre CSV'ye Dışa Aktar"  
    Write-host "2. Tüm AD Kullanıcılarını Ada ve LastLogonDate'e Göre CSV'ye Dışa Aktar"
    Write-host "3. Hiçbir Zaman Süresi Dolmayacak Parola Ayarlı Tüm Hesapları CSV'ye Dışa Aktar" 
    Write-host "4. AD Bilgisayarlarını CSV dosyasına aktar" 
    Write-host "5. Belirli OU'dan AD Bilgisayarlarını CSV'ye Dışa Aktar" 
    Write-host "Aşağıdaki Raporlar Direk PS ekranına Gelecektir Herhangibirtuşa Basarak Menüye Geri Dönebilirsiniz.."  -ForegroundColor White -BackgroundColor red 
    Write-host "6. Tüm Devre Dışı Bırakılan Kullanıcı Hesaplarını Alın" 
    Write-host "7. Tüm Kilitli Kullanıcı Hesaplarını Alın" 
    Write-host "8. Tüm Expire olmuş accountları listeler." 
    Write-host "9. Tüm Passwordu expire olmuş userları listeler." 
    Write-host "10.Tüm Passwordu never expires işaretlenmiş olan userları listeler." 
    Write-host "Etki Alanı Raporları"  -ForegroundColor White -BackgroundColor red 
    Write-host "11. Tüm Etki Alanı Denetleyicilerini Ana Bilgisayar Adına ve İşletime Göre Alın" 
    Write-host "12. Etki Alanı Varsayılan Parola Politikasını Alın" 
    Write-host "13. İşletim Sistemine Göre Tüm Bilgisayarların Sayısını Alın" 
    Write-host "14. Duruma göre tüm GPO'ları alın" 
    Write-host "M. Ana Menüye Dön" -ForegroundColor White -BackgroundColor red
    write-output "" 
    $Rmenulistenumarasi = read-host "Menüden Yapmak İstediğiniz İşlemin Numarasını Giriniz" 
    switch ($Rmenulistenumarasi)
    {
    #
     1 {
      cls
     Get-ADUser -Filter * -Properties * | Select-Object name | export-csv -path c:\temp\userexport.csv
     Write-host "'userexport.csv' Oluşturulmuştur.." -ForegroundColor White -BackgroundColor red 
      pause
      cls
     Rmenu
       }
       #
     2 {
      cls
     Get-ADUser -Filter * -Properties * | Select-Object name, LastLogonDate | export-csv -path c:\temp\userLastLogonexport.csv
     Write-host "'userLastLogonexport.csv' Oluşturulmuştur.." -ForegroundColor White -BackgroundColor red 
       pause
       cls
     Rmenu
       }
       #
     3 {
      cls
     get-aduser -filter * -properties Name, PasswordNeverExpires | where {$_.passwordNeverExpires -eq "true" } | Select-Object DistinguishedName,Name,Enabled | export-csv -path c:\temp\export.csv
     Write-host "'export.csv' Oluşturulmuştur.." -ForegroundColor White -BackgroundColor red 
       pause
       cls
     Rmenu
       }
       #
     4 {
      cls
     Get-AdComputer -filter * | export-csv -path c:\temp\Computers.csv 
     Write-host "'Computers.csv' Oluşturulmuştur.." -ForegroundColor White -BackgroundColor red 
       pause
       cls
     Rmenu
       }
       #
     5 {
      cls
     $OUFilter= Read-Host "Dışa Aktarılacak Bilgisayarların Aktarılacağı OU'yu Yazınız.."
     Get-ADComputer -SearchBase "OU=$OUFilter" -Filter * | export-csv -path c:\temp\userLastLogonexport.csv
     Write-host "'$OUFilterComputer.csv' Oluşturulmuştur.." -ForegroundColor White -BackgroundColor red 
       pause
       cls
     Rmenu
       }
       #
     6 {      clear
      Search-ADAccount -AccountDisabled | select name
      pause
      cls
      Rmenu
       }
       #
     7 {      cls
      Search-ADAccount -LockedOut
      pause
      cls
     Rmenu
       }
       
       #
     8 {      cls
      Search-ADAccount –AccountExpired
      pause
      cls
      Rmenu
       }
       #
     9 {      cls
      Search-ADAccount –PasswordExpired 
      pause
      cls
      Rmenu
       }
       #
     10 {      cls
      Search-ADAccount –PasswordNeverExpires | ft name 
      pause
      cls
      Rmenu
       }
       #
     11 {cls
      Get-ADDomainController -filter * | select hostname, operatingsystem
      pause
      cls
      Rmenu
       }
       #
     12 {
      cls
      Get-ADDefaultDomainPasswordPolicy
      pause
      cls
      Rmenu
       }       
       #
     13 {
      cls
      Get-ADComputer -Filter "name -like '*'" -Properties operatingSystem | group -Property operatingSystem | Select Name,Count
      pause
      cls
      Rmenu
       }       
       #
     14 {
      cls
      get-GPO -all | select DisplayName, gpostatus
      pause
      cls
      Rmenu
       }         
       #             
     #MENU
     M { Menu }
    }
    }
    Rmenu
}
 C { cls
 Write-host "PowerShell Script Ekleme Düzeltme Fikir ve Önerileriniz için uguryldz1994@gmail.com"  -foregroundcolor white -BackgroundColor red   
 pause
  exit}
}
}
Menu
#Main Menu
