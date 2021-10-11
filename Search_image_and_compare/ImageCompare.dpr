program ImageCompare;

uses
  Forms,
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  SearchProgressFormUnit in 'SearchProgressFormUnit.pas' {SearchProgressForm},
  DecisionFormUnit in 'DecisionFormUnit.pas' {DecisionForm},
  CompareProgressFormUnit in 'CompareProgressFormUnit.pas' {CompareProgressForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSearchProgressForm, SearchProgressForm);
  Application.CreateForm(TDecisionForm, DecisionForm);
  Application.CreateForm(TCompareProgressForm, CompareProgressForm);
  Application.Run;
end.
