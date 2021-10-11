unit SearchProgressFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TSearchProgressForm = class(TForm)
    Animate1: TAnimate;
    BitBtn1: TBitBtn;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SearchProgressForm: TSearchProgressForm;

implementation

uses
  MainFormUnit;

{$R *.dfm}

procedure TSearchProgressForm.Timer1Timer(Sender: TObject); // Mise à jour des informations
begin
  if Visible then begin
    StaticText1.Caption:=Format('Found %d files',[MainForm.FileCount]);
    StaticText2.Caption:=Format('Looked into %d folders',[MainForm.FolderCount]);
    StaticText3.Caption:=Format('Looking in .\%s',[MainForm.CurrentFolder]);
  end;
end;

procedure TSearchProgressForm.FormShow(Sender: TObject);
begin
  Animate1.Active:=True;
end;

end.
