program HideTaskb;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,Winapi.Windows;

var
aStr:String;
Hiding:boolean;

begin
  try


   Hiding:=true;
   if ParamCount>0 then
     begin
       aStr:=UpperCase(ParamStr(1));
       if POS('SHOW',aStr)>0 then
         Hiding:=False;
     end;


   if Hiding then
    ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_HIDE) else
    ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_SHOW);




  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
