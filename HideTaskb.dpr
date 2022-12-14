program HideTaskb;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,Winapi.Windows,System.Win.Registry,System.IOUtils,ShellApi;


function RunAsAdmin(const Handle: Hwnd; const Path, Params: string): integer;
begin
  Result:=ShellExecute(Handle, 'runas', PChar(Path),PChar(Params), nil, SW_SHOWNORMAL);
end;



var
aStr,aPath,aCurr:String;
Hiding,KillCurr:boolean;
reg:tRegistry;

begin
  try

  aPath:=ExtractFilePath(ParamStr(0));
   if TFile.Exists(aPath+'HideCursor.exe') then
     KillCurr:=true else KillCurr:=false;


   Hiding:=true;
   if ParamCount>0 then
     begin
       aStr:=UpperCase(ParamStr(1));
       if POS('SHOW',aStr)>0 then
         Hiding:=False;
     end;


   if Hiding then
     begin
    ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_HIDE);
     if KillCurr then
      begin
       reg:=tRegistry.Create(KEY_READ);
       if reg.OpenKey('Control Panel\Cursors\',false) then
         begin
           aCurr:=reg.ReadString('Arrow');
           if POS('HIDDEN',UpperCase(aCurr))<1 then
             begin
               RunAsAdmin(0,aPath+'HideCursor.exe','');
             end;
         end;
           reg.CloseKey;
           reg.Free;
      end;
    end else
      begin
      ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_SHOW);
     if KillCurr then
      begin
       reg:=tRegistry.Create(KEY_READ);
       if reg.OpenKey('Control Panel\Cursors\',false) then
         begin
           aCurr:=reg.ReadString('Arrow');
           if POS('HIDDEN',UpperCase(aCurr))>0 then
             begin
               RunAsAdmin(0,aPath+'HideCursor.exe','/show');
             end;
           reg.CloseKey;
           reg.Free;
         end;
      end;

      end;



  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
