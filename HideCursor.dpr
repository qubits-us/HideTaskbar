program HideCursor;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,Winapi.Windows,System.Win.Registry,System.IOUtils,ShellApi;



var
aStr,aPath,aCurr:String;
Hiding,KillCurr:boolean;
reg:tRegistry;

begin
  try

  aPath:=ExtractFilePath(ParamStr(0));
   if TFile.Exists(aPath+'Hidden.cur') then
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
     if KillCurr then
      begin
       reg:=tRegistry.Create(KEY_ALL_ACCESS);
       if reg.OpenKey('Control Panel\Cursors\',false) then
         begin
           aCurr:=reg.ReadString('Arrow');
           if POS('HIDDEN',UpperCase(aCurr))<1 then
             begin
               reg.WriteString('Arrow',aPath+'Hidden.cur');

             end;
           reg.CloseKey;
           reg.Free;
         end;
      end;
    end else
      begin
     if KillCurr then
      begin
       reg:=tRegistry.Create(KEY_ALL_ACCESS);
       if reg.OpenKey('Control Panel\Cursors\',false) then
         begin
           aCurr:=reg.ReadString('Arrow');
           if POS('HIDDEN',UpperCase(aCurr))>0 then
             begin
               //set back to default
               reg.WriteString('Arrow','C:\WINDOWS\cursors\aero_arrow.cur');
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
