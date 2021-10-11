unit CompareProgressFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TCompareProgressForm = class(TForm)
    Animate1: TAnimate;
    BitBtn1: TBitBtn;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CompareProgressForm: TCompareProgressForm;

implementation

uses
  MainFormUnit;

{$R *.dfm}

procedure TCompareProgressForm.Timer1Timer(Sender: TObject);    // Mise à jour des informations affichées
begin
  if Visible then begin
    ProgressBar1.Position:=Round(MainForm.CompareProgress*1000);
    Caption:=Format('Looking for similar images (%d%% complete)...',[Round(100*MainForm.CompareProgress)]);
  end;
end;

procedure TCompareProgressForm.FormShow(Sender: TObject);
begin
  Animate1.Active:=True;
end;

end.
