unit MainFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShlObj, Buttons, StdCtrls, ExtCtrls, ToolWin, ComCtrls, ExtDlgs,
  ImgList, Menus, StrUtils, SearchProgressFormUnit, CompareProgressFormUnit,
  DecisionFormUnit, ShellAPI, JPEG;

type
  TMainForm = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    CheckBox1: TCheckBox;
    BitBtn1: TBitBtn;
    GroupBox2: TGroupBox;
    ListView1: TListView;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    PopupMenu1: TPopupMenu;
    Details1: TMenuItem;
    List1: TMenuItem;
    Details2: TMenuItem;
    Smallicons1: TMenuItem;
    ImageList3: TImageList;
    ToolButton2: TToolButton;
    PopupMenu2: TPopupMenu;
    Byname1: TMenuItem;
    Bydimensions1: TMenuItem;
    Byfilesize1: TMenuItem;
    Bydate1: TMenuItem;
    N1: TMenuItem;
    Ascendant1: TMenuItem;
    Descendant1: TMenuItem;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    TrackBar1: TTrackBar;
    ComboBox1: TComboBox;
    ToolButton3: TToolButton;
    Panel2: TPanel;
    ImageList4: TImageList;
    ToolButton4: TToolButton;
    Panel3: TPanel;
    ComboBox2: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Smallicons1Click(Sender: TObject);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure BitBtn2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure ComboBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Descendant1Click(Sender: TObject);
    procedure Bydate1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    FAscendantOrder:Boolean;    // Ordre de classement croissant/décroissant
    FColumnSortID:Integer;      // Critère de classement
  public
    CurrentFolder:string;       // Variables utilisées par les fenêtres de progression
    FileCount,FolderCount:Integer;
    CompareProgress:Single;

    procedure ClearData;       // Pour nettoyer le ListView (la propriété Data des TListItem contient un pointeur vers une matrice de coefficients)
  end;

  TTriVertex=packed record
    x:Longint;
    y:Longint;
    Red:Word;
    Green:Word;
    Blue:Word;
    Alpha:Word;
  end;

  TSingleArray=array[0..$FFFFFF] of Single;
  PSingleArray=^TSingleArray;

  TSearchThread=class(TThread)   // Thread de recherche de fichiers images
  private
    FSearchData:TSearchRec;      // Variables utilisées dans la méthode synchronisée
    FPicture:TPicture;
    FBitmap1,FBitmap2:TBitmap;
    FRect1,FRect2:TRect;
    FPath,FSubPath:string;
    FSize:Integer;
    FBuffer:PSingleArray;
  protected
    procedure Execute;override;
    procedure Finished;          // Méthode appelée à la fin du thread pour enlever la fenêtre de progression
    procedure AddFile;           // Méthode synchronisée avec le thread principal pour manipuler le ListView1
  end;

  TCompareThread=class(TThread)  // Thread de comparaison des fichiers images trouvés
  private
    FFile1,FFile2:string;        // Variables utilisées dans la méthode synchronisée
    FAction:TImageAction;
    FSimilarity:Single;
  protected
    procedure Execute;override;
    procedure Finished;          // Méthode appelée à la fin du thread pour enlever la fenêtre de progression
    procedure FileAction;        // Méthode synchronisée avec le thread principal pour manipuler le ListView1 et lancer le dialogue de suppression
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

function CallBack(Wnd:HWND;uMsg:UINT;wParam,lpData:LPARAM):Integer;stdcall;  // Fonction de "callback" appelée à l'initialisation de la
begin                                                                        // boîte de sélection de répertoire pour définir le répertoire
  if uMsg=BFFM_INITIALIZED then                                              // par défaut
    SendMessage(Wnd,BFFM_SETSELECTION,1,lpData);
  Result:=0;
end;

function SelectFolder(var Folder:string;const AllowCreateNew:Boolean=False;const Title:string=''):Boolean;  // Fonction pour demander à l'utilisateur de
const                                                                                                       // choisir un répertoire
  BIF_NEWDIALOGSTYLE=$0040;                                                                                 //   Folder: le répertoire par défaut
var                                                                                                         //           qui contiendra le répertoire
  BI:TBrowseInfo;                                                                                           //           choisi en cas de confirmation
  p:PItemIDList;                                                                                            //   AllowCreateNew: autorise ou non la possibilité
begin                                                                                                       //           de créer un nouveau dossier
  ZeroMemory(@BI,SizeOf(BI));                                                                               //   Title: titre de la boîte de dialogue
  with BI do begin                                                                                          //   Résultat: True si l'utilisation a cliqué
    hwndOwner:=Application.Handle;                                                                          //           sur OK, False sinon
    pszDisplayName:=PChar(Folder);
    lpszTitle:=PChar(Title);
    ulFlags:=BIF_RETURNONLYFSDIRS;
    if AllowCreateNew then
      ulFlags:=ulFlags or BIF_NEWDIALOGSTYLE;
    if Folder<>'' then begin
      lParam:=Integer(PChar(Folder));
      lpfn:=CallBack;
    end;
  end;
  p:=SHBrowseForFolder(BI);
  if Assigned(p) then begin
    SetLength(Folder,MAX_PATH);
    Result:=SHGetPathFromIDList(p,PChar(Folder));
    GlobalFreePtr(p);
    SetLength(Folder,Length(PChar(Folder)));
  end else
    Result:=False;
end;

{ TSearchThread }

procedure TSearchThread.AddFile;  // Procédure synchronisée avec le thread principal pour ajoutter un item dans le TListView

  function BuildWavelet:PSingleArray;  // Fonction qui construit la transformée en ondelettes de Haar de l'image
  var
    a,b,c,d,e:Integer;
    s:PByteArray;
  begin
    GetMem(Result,FBitmap2.Width*FBitmap2.Height*3*SizeOf(Single));
    for b:=0 to FBitmap2.Height-1 do begin
      s:=FBitmap2.ScanLine[b];
      for a:=0 to 3*FBitmap2.Width-1 do
        Result[FSize*b*3+a]:=s[a];
    end;
    c:=FSize;
    while c>1 do begin                 // Transformée en paquets d'ondelettes...
      e:=c div 2;
      for d:=0 to 2 do begin           // On fait successivement la transformée des 3 canaux RGB
        for a:=0 to FSize-1 do begin   // Transformée horizontale
          for b:=0 to c-1 do
            FBuffer[b]:=Result[(FSize*a+b)*3+d];
          for b:=0 to e-1 do begin
            Result[(FSize*a+b)*3+d]:=0.5*(FBuffer[2*b]+FBuffer[2*b+1]);
            Result[(FSize*a+b+e)*3+d]:=0.5*(FBuffer[2*b+1]-FBuffer[2*b]);
          end;
        end;
        for a:=0 to FSize-1 do begin   // Transformée verticale
          for b:=0 to c-1 do
            FBuffer[b]:=Result[(FSize*b+a)*3+d];
          for b:=0 to e-1 do begin
            Result[(FSize*b+a)*3+d]:=0.5*(FBuffer[2*b]+FBuffer[2*b+1]);
            Result[(FSize*(b+e)+a)*3+d]:=0.5*(FBuffer[2*b+1]-FBuffer[2*b]);
          end;
        end;
      end;
      c:=c div 2;                      // Passage à l'échelle suivante
    end;
  end;

begin
  MainForm.CurrentFolder:=FSubPath;    // Variables utilisées par la fenêtre de progression...
  FPicture.LoadFromFile(FPath+'\'+FSearchData.Name);
  FBitmap1.Canvas.StretchDraw(FRect1,FPicture.Graphic);
  FBitmap2.Canvas.StretchDraw(FRect2,FPicture.Graphic);
  with MainForm,ListView1.Items.Add do begin
    Data:=BuildWavelet;
    Caption:=FSubPath+FSearchData.Name;
    SubItems.Add(Format('%d x %d',[FPicture.Width,FPicture.Height]));
    {$WARNINGS OFF}
    SubItems.Add(IntToStr(Int64(FSearchData.FindData.nFileSizeHigh) shl 32+FSearchData.FindData.nFileSizeLow));
    {$WARNINGS ON}
    SubItems.Add(DateTimeToStr(FileDateToDateTime(FileAge(FPath+'\'+FSearchData.Name))));
    ImageIndex:=ImageList1.Add(FBitmap1,nil);
    ImageList2.Add(FBitmap2,nil);
  end;
  Inc(MainForm.FileCount);
end;

procedure TSearchThread.Execute;
var
  l:TStringList;

  procedure ListFolder(Path:string;SubPath:string);    // Parcours récursif (en fonction de CheckBox1.Checked) d'un répertoire
  var
    f:TSearchRec;
  begin
    Inc(MainForm.FolderCount);
    if FindFirst(Path+'\*',faAnyFile or faDirectory,f)=0 then
      try
        repeat
          if Terminated then
            Break;
          if f.Attr and faDirectory=faDirectory then begin
            if MainForm.CheckBox1.Checked and (f.Name<>'.') and (f.Name<>'..') then
              ListFolder(Path+'\'+f.Name,SubPath+f.Name+'\');
          end else
            if l.IndexOf(ExtractFileExt(f.Name))>-1 then begin  // Si l'extension est une extension graphique connue (en l'occurence *.JPEG, *.BMP, *.ICO, *.WMF)
              try
                FSearchData:=f;
                FSubPath:=SubPath;
                FPath:=Path;
                Synchronize(AddFile);  // Synchronisation de la méthode d'ajout
              except
                ;
              end;
            end;
        until FindNext(f)<>0;
      finally
        FindClose(f);
      end;
  end;

begin
  l:=TStringList.Create;
  l.Text:=AnsiReplaceText(AnsiReplaceStr(GraphicFileMask(TGraphic),';',#13),'*','');   // Extraction de la liste des extensions graphiques connues
  l.CaseSensitive:=False;
  FPicture:=TPicture.Create;
  FBitmap1:=TBitmap.Create;
  FBitmap1.Width:=MainForm.ImageList1.Width;
  FBitmap1.Height:=MainForm.ImageList1.Height;
  FRect1:=Rect(0,0,FBitmap1.Width,FBitmap1.Height);
  FBitmap2:=TBitmap.Create;
  FBitmap2.Width:=MainForm.ImageList2.Width;
  FBitmap2.Height:=MainForm.ImageList2.Height;
  FBitmap2.PixelFormat:=pf24bit;   // Format RGB24
  FRect2:=Rect(0,0,FBitmap2.Width,FBitmap2.Height);
  FSize:=FBitmap2.Width;
  GetMem(FBuffer,FSize*SizeOf(Single));  // Buffer de travail...
  MainForm.ListView1.Items.BeginUpdate;  // Pour éviter des réaffichages multiples
  try
    ListFolder(MainForm.Edit1.Text,'');
  finally
    MainForm.ListView1.Items.EndUpdate;
    FreeMem(FBuffer);
    FBitmap2.Destroy;
    FBitmap1.Destroy;
    FPicture.Destroy;
    l.Destroy;
    if not Terminated then
      Synchronize(Finished);             // On cache la fenêtre de progression si elle est encore visible
  end;
end;

procedure TSearchThread.Finished;        // On cache la fenêtre de progression si elle est encore visible
begin
  if SearchProgressForm.Visible then
    SearchProgressForm.ModalResult:=mrOk;
end;

{ TCompareThread }

procedure TCompareThread.Execute;
var
  a,b,c,n:Integer;
  t:PSingleArray;
  r,m:Single;
const
  u:array[0..1,0..1] of Single=((0.25,1),(1,1));

  function Dist(p,q:PSingleArray):Single;  // Distance de 2 transformées d'ondelettes
  var
    a,b,c:Integer;
  begin
    Result:=0;
    for a:=0 to n-1 do begin
      if Result>m then          // Si les 2 images sont déjà assez différentes, pas besoin de faire le calcul jusqu'au bout.
        Exit;
      for b:=0 to n-1 do
        for c:=0 to 2 do
          Result:=Result+t[n*a+b]*Abs(p[(n*a+b)*3+c]-q[(n*a+b)*3+c]);   // Ajout des différences pondérées des 2 transformées en ondelettes
    end;
  end;

begin
  n:=MainForm.ImageList2.Width;
  GetMem(t,n*n*SizeOf(Single));   // Matrice de pondération multi-échelle
  c:=1;
  r:=1/16;
  t[0]:=1;
  while c<n do begin  // remplissage de la matrice de pondérations
    for a:=0 to c-1 do
      for b:=0 to c-1 do begin
        t[n*(a+c)+b]:=r*u[1,0];
        t[n*a+b+c]:=r*u[0,1];
        t[n*(a+c)+b+c]:=r*u[1,1];
      end;
    c:=2*c;
    r:=r*u[0,0];
  end;
  m:=100-MainForm.TrackBar1.Position/10;
  DecisionForm.Canceled:=False;
  DecisionForm.CheckBox1.Checked:=False;
  try
    a:=0;
    with MainForm do
      while a<ListView1.Items.Count do begin
        MainForm.CompareProgress:=a/(ListView1.Items.Count+1);
        for b:=ListView1.Items.Count-1 downto a+1 do begin
          FSimilarity:=100-Dist(ListView1.Items[a].Data,ListView1.Items[b].Data);
          if (FSimilarity>=TrackBar1.Position/10) then begin
            FFile1:=Edit1.Text+'\'+ListView1.Items[a].Caption;
            FFile2:=Edit1.Text+'\'+ListView1.Items[b].Caption;
            Synchronize(FileAction);  // Synchronisation de l'affichage du dialogue de suppression
            case FAction of  // Mise à jour du ListView1 en fonction de l'action choisie par l'utilisateur
              iaDelete1:begin
                FreeMem(ListView1.Items[a].Data);
                ListView1.Items.Delete(a);
                Dec(a);
                Break;
              end;
              iaDelete2:begin
                FreeMem(ListView1.Items[b].Data);
                ListView1.Items.Delete(b);
              end;
            end;
          end;
          if DecisionForm.Canceled or Terminated then   // Action annulée...
            Break;
        end;
        if DecisionForm.Canceled or Terminated then     // Action annulée...
          Break;
        Inc(a);
      end;
  finally
    FreeMem(t);
  end;
  if not Terminated then
    Synchronize(Finished);    // On ferme la fenêtre de progression si elle est encore visible...
end;

procedure TCompareThread.FileAction;

  procedure DoDeleteFile(FileName:string); // Suppression d'un fichier
  var
    FOS:TSHFileOpStruct;
  begin
    if MainForm.ComboBox1.ItemIndex=1 then begin
      if not DeleteFile(FileName) then     // Suppression irréversible
        RaiseLastOSError;
    end else begin
      ZeroMemory(@FOS,SizeOf(FOS));        // Envoi à la corbeille
      with FOS do begin
        wFunc:=FO_DELETE;
        pFrom:=PChar(FileName+#0#0);
        fFlags:=FOF_ALLOWUNDO or FOF_NOCONFIRMATION or FOF_SILENT;
      end;
      if ShFileOperation(FOS)<>0 then
        RaiseLastOSError;
    end;
  end;

begin
  FAction:=DecisionForm.Execute(FFile1,FFile2,FSimilarity);  // On demande son avis à l'utilisateur...
  case FAction of     // Et on fait ce qu'il a décidé...
    iaDelete1:DoDeleteFile(FFile1);
    iaDelete2:DoDeleteFile(FFile2);
  end;
end;

procedure TCompareThread.Finished;
begin
  if CompareProgressForm.Visible then
    CompareProgressForm.ModalResult:=mrOk; // On ferme la fenêtre de progression si elle est encore visible...
end;

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Edit1.Text:=GetCurrentDir;   // On se met dans le répertoire de travail
end;

procedure TMainForm.BitBtn1Click(Sender: TObject);
const
  T:array[0..3] of Integer=(16,32,64,128); // Qualités de la transformée en ondelettes: Low, Average, Good, Very good
begin
  ClearData;            // On efface les données précédantes
  ImageList2.Width:=T[ComboBox2.ItemIndex];  // La taille de ImageList2 va définir la taille de la transformée en ondelettes (en fonction de la qualité désirée)
  ImageList2.Height:=T[ComboBox2.ItemIndex];
  CurrentFolder:='';    // Initialisations diverses...
  FileCount:=0;
  FolderCount:=0;
  with TSearchThread.Create(False) do begin   // Lancement du thread de recherche
    if SearchProgressForm.ShowModal=mrCancel then begin // Affichage de la fenêtre de progression: si l'utilisateur appuie dur "cancel"...
      Terminate;                                        // ...alors on arrête le thread
      WaitFor;
    end;
    Destroy;
  end;
  GroupBox2.Caption:=Format('%d graphic files',[ListView1.Items.Count]); // Nombre de fichiers trouvés
  BitBtn2.Enabled:=True;                                                 // On peut passer à l'étape suivante
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
var
  s:string;
begin
  s:=Edit1.Text;
  if SelectFolder(s) then begin      // Changement du répertoire de recherche
    Edit1.Text:=s;
    ClearData;
  end;
end;

procedure TMainForm.Smallicons1Click(Sender: TObject);
var
  a:Integer;
begin                                       // En fonction du menu coché, on adapte l'affichage du ListView
  for a:=0 to PopupMenu1.Items.Count-1 do
    if PopupMenu1.Items[a].Checked then
      ListView1.ViewStyle:=TViewStyle(a);
end;

procedure TMainForm.ListView1Compare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);

  function BoolSgn(x:Boolean):Integer;
  begin
    if x then
      Result:=1
    else
      Result:=-1;
    if FAscendantOrder then
      Result:=-Result;
  end;

  function StrToDim(s:string):Integer;
  var
    a:Integer;
  begin
    a:=Pos(' x ',s);
    Result:=StrToInt(Copy(s,1,a-1))*StrToInt(Copy(s,a+3,Length(s)));
  end;

begin
  case FColumnSortID of      // Différentes méthodes de comparaison en fonction de la colonne cliquée
    0:Compare:=BoolSgn(Item1.Caption>Item2.Caption);
    1:Compare:=BoolSgn(StrToDim(Item1.SubItems[0])>StrToDim(Item2.SubItems[0]));
    2:Compare:=BoolSgn(StrToInt(Item1.SubItems[1])>StrToInt(Item2.SubItems[1]));
    3:Compare:=BoolSgn(StrToDateTime(Item1.SubItems[2])>StrToDateTime(Item2.SubItems[2]));
  end;
end;

procedure TMainForm.ListView1ColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  if Column.Index=FColumnSortID then begin   // Si on a cliqué 2 fois sur la même colonne
    FAscendantOrder:=not FAscendantOrder;    // alors on inverse l'ordre de classement
    Ascendant1.Checked:=not FAscendantOrder; // Mise à jour du menu coché
    Descendant1.Checked:=FAscendantOrder;
  end;
  FColumnSortID:=Column.Index;
  PopupMenu2.Items[FColumnSortID].Checked:=True; // Mise à jour du menu coché
  ListView1.CustomSort(nil,0);                   // on classe les items
end;

procedure TMainForm.ClearData;    // libération de la mémoire occupée par les transformées en ondelette et on vide le ListView1
var
  a:Integer;
begin
  BitBtn2.Enabled:=False;
  ListView1.Items.BeginUpdate;
  try
    for a:=0 to ListView1.Items.Count-1 do
      FreeMem(ListView1.Items[a].Data);
    ListView1.Clear;
  finally
    ListView1.Items.EndUpdate;
  end;
  ImageList1.Clear;                 // on efface les listes d'images
  ImageList2.Clear;
  ListView1.Repaint;
end;

procedure TMainForm.BitBtn2Click(Sender: TObject);
begin
  with TCompareThread.Create(False) do begin     // Lancement du thread de comparaison
    if CompareProgressForm.ShowModal=mrCancel then begin  // Si l'utilisateur annule l'opération
      Terminate;                                          // on arrête le thread
      WaitFor;
    end;
    Destroy;
  end;
  GroupBox2.Caption:=Format('%d graphic files',[ListView1.Items.Count]);  // Nombre de fichiers restants
end;

procedure TMainForm.TrackBar1Change(Sender: TObject);
begin
  Panel1.Caption:=Format('Max similarity value: %f %%',[TrackBar1.Position/10]); // Mise à jour de l'interface
end;

procedure TMainForm.ComboBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with ComboBox1,ComboBox1.Canvas do begin  // Affichage des icônes de la ComboBox
    if odSelected in State then
      Brush.Color:=clHighlight;
    Dec(Rect.Right,1);
    FillRect(Rect);
    ImageList4.Draw(Canvas,Rect.Left+1,Rect.Top,Index);
    TextOut(Rect.Left+21,Rect.Top+2,Items[Index]);
  end;
end;

procedure TMainForm.Descendant1Click(Sender: TObject);
begin
  FAscendantOrder:=Ascendant1=Sender;                         // Changement de l'ordre d'affichage
  ListView1ColumnClick(nil,ListView1.Columns[FColumnSortID]);
end;

procedure TMainForm.Bydate1Click(Sender: TObject);
begin
  FColumnSortID:=PopupMenu2.Items.IndexOf(TMenuItem(Sender)); // Changement du critère d'affichage
  ListView1ColumnClick(nil,ListView1.Columns[FColumnSortID]); // On range de nouveau les items
end;

procedure TMainForm.ComboBox2Change(Sender: TObject);
begin
  ClearData; // On doit recalculer les transformées en ondelettes donc on efface tout
end;

end.
