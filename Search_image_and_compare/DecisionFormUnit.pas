unit DecisionFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TImageAction=(iaDelete1,iaDelete2,iaNone);     // Action choisie par l'utilisateur: supprimer la 1ère image, la seconde, ou ne rien faire

  TDecisionForm = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    StaticText1: TStaticText;
    ScrollBox1: TScrollBox;
    PaintBox1: TPaintBox;
    GroupBox2: TGroupBox;
    StaticText2: TStaticText;
    ScrollBox2: TScrollBox;
    PaintBox2: TPaintBox;
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
  private
    FPicture1,FPicture2:TPicture;
  public
    Canceled:Boolean;

    function Execute(FileName1,FileName2:string;Similiraty:Single):TImageAction;     // Renvoie l'action choisie par l'utilisateur
  end;

var
  DecisionForm: TDecisionForm;

implementation

uses
  MainFormUnit;

{$R *.dfm}

procedure TDecisionForm.FormCreate(Sender: TObject);
begin
  FPicture1:=TPicture.Create;
  FPicture2:=TPicture.Create;
end;

procedure TDecisionForm.FormDestroy(Sender: TObject);
begin
  FPicture1.Destroy;
  FPicture2.Destroy;
end;

procedure TDecisionForm.Panel1Resize(Sender: TObject);
begin
  GroupBox1.Width:=Panel1.ClientWidth div 2;
end;

procedure TDecisionForm.RadioGroup1Click(Sender: TObject);
begin
  BitBtn1.Enabled:=RadioGroup1.ItemIndex>-1;  // Il faut déjà prendre une décision avant de pouvoir la confirmer
end;

procedure TDecisionForm.PaintBox1Paint(Sender: TObject);
begin
  PaintBox1.Canvas.Draw(0,0,FPicture1.Graphic);  // Affichage de l'image 1
end;

procedure TDecisionForm.PaintBox2Paint(Sender: TObject);
begin
  PaintBox2.Canvas.Draw(0,0,FPicture2.Graphic);  // Affichage de l'image 2
end;

function GetFileSize(FileName:string):Int64;   // Donne la taille d'un fichier
var
  f:TSearchRec;
begin
  if FindFirst(FileName,faAnyFile,f)=0 then
    try
      {$WARNINGS OFF}
      Result:=Int64(f.FindData.nFileSizeHigh) shl 32+f.FindData.nFileSizeLow;
      {$WARNINGS ON}
    finally
      FindClose(f);
    end
  else
    Result:=0;
end;

function TDecisionForm.Execute(FileName1, FileName2: string;
  Similiraty: Single): TImageAction;
var
  m:TModalResult;
const
  T:array[False..True] of TImageAction=(iaDelete1,iaDelete2);
begin
  Result:=iaNone;
  if CheckBox1.Checked then // Si l'utilisateur a décidé de toujours faire la même action
    m:=mrOk                 // on ne lui demande pas son avis de nouveau
  else begin
    Caption:=Format('Similarity: %f %%',[Similiraty]);
    StaticText1.Caption:='.\'+Copy(FileName1,Length(MainForm.Edit1.Text)+2,Length(FileName1));
    StaticText2.Caption:='.\'+Copy(FileName2,Length(MainForm.Edit1.Text)+2,Length(FileName2));
    FPicture1.LoadFromFile(FileName1);
    FPicture2.LoadFromFile(FileName2);
    with FPicture1 do
      PaintBox1.SetBounds(0,0,Width,Height);
    with FPicture2 do
      PaintBox2.SetBounds(0,0,Width,Height);
    m:=ShowModal;           // on demande son avis à l'utilisateur
  end;
  case m of
    mrOk:begin
      case RadioGroup1.ItemIndex of
        0,4:Result:=T[RadioGroup1.ItemIndex=4];
        1,5:Result:=T[(FPicture1.Width*FPicture1.Height<FPicture2.Width*FPicture2.Height) xor (RadioGroup1.ItemIndex=1)];
        2,6:Result:=T[(GetFileSize(FileName1)<GetFileSize(FileName2)) xor (RadioGroup1.ItemIndex=2)];
        3,7:Result:=T[(FileDateToDateTime(FileAge(FileName1))<FileDateToDateTime(FileAge(FileName2))) xor (RadioGroup1.ItemIndex=3)];
      end;
    end;
    mrCancel:Canceled:=True;  // Opération annulée
  else
    CheckBox1.Checked:=False; // Si l'utilisateur n'a pas pris de décision, alors on lui demandera son avis la prochaine fois
  end;
end;

end.
