; Script generated for Tarket Dev Roadmap Application
#define MyAppName "Tarket"
#define MyAppArabicName "تاركت - مسار المطور"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Tarket Team"
#define MyAppExeName "tarket.exe"
#define MyAppAssocName MyAppName + " File"
#define MyAppAssocExt ".tarket"
#define MyAppAssocKey StringChange(MyAppAssocName, " ", "") + MyAppAssocExt

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
AppId={{D37F648A-0B97-4A2D-B81C-9E45E8F3C882}
AppName={#MyAppArabicName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\Tarket
DisableProgramGroupPage=yes
; Allow installing without admin privileges
PrivilegesRequired=lowest
OutputDir=c:\projects\tarket\dist_installer
OutputBaseFilename=Tarket_Setup_v1.0.0
SetupIconFile=c:\projects\tarket\windows\runner\resources\app_icon.ico
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "إنشاء اختصار على سطح المكتب (Desktop Shortcut)"; GroupDescription: "اختصارات إضافية:"

[Files]
Source: "c:\projects\tarket\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\{#MyAppArabicName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\app_icon.ico"
Name: "{autodesktop}\{#MyAppArabicName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\app_icon.ico"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "تشغيل تطبيق تاركت الآن (Launch Tarket)"; Flags: nowait postinstall skipifsilent
