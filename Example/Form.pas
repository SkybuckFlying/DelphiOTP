unit Form;

{

original version 1.00 by wendelb

https://github.com/wendelb/DelphiOTP

version 1.01 created on 12 march 2024 by Skybuck Flying

+ IFNDEFS problems with FPC solved for Delphi.
+ Position set to screen center.
+ Controls widened a bit to be able to input/see/handle larger security codes.

Application tested and works ! Nice ! =D
Application is compatible with google authenticator.

}

interface

uses
  Winapi.Windows, System.SysUtils, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, System.Classes;

type
  TFormOTP = class(TForm)
    EdtKey: TEdit;
    Label1: TLabel;
    CBTOPT: TCheckBox;
    Label2: TLabel;
    EdtHOTP: TEdit;
    BtnCalculate: TButton;
    Label3: TLabel;
    EdtResult: TEdit;
    procedure BtnCalculateClick(Sender: TObject);
    procedure CBTOPTClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormOTP: TFormOTP;

implementation

{$R *.dfm}

uses
  GoogleOTP;

procedure TFormOTP.BtnCalculateClick(Sender: TObject);
var
  Secret: String;
  n: Integer;
begin
  Secret := EdtKey.Text;

  if (CBTOPT.Checked) then
  begin
    // This is the default in case the parameter is missing!
    n := -1;
  end
  else
  begin
    if (not TryStrToInt(EdtHOTP.Text, n)) then
    begin
      MessageBox(Handle, 'Please enter a valid number into the counter',
        'One Time Password Example', MB_ICONEXCLAMATION);
      Exit;
    end;
  end;

  EdtResult.Text := Format('%.6d', [CalculateOTP(Secret, n)]);
end;

procedure TFormOTP.CBTOPTClick(Sender: TObject);
begin
  Label2.Enabled := not CBTOPT.Checked;
  EdtHOTP.Enabled := not CBTOPT.Checked;
end;

end.
