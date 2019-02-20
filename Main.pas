unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormMain = class(TForm)
    Memo3: TMemo;
    ButtonSum: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    ButtonCheckAlg: TButton;
    ButtongetRandomNums: TButton;
    ButtonAboutMe: TButton;
    ButtonAlg: TButton;
    EditRndSz: TEdit;
    procedure ButtonSumClick(Sender: TObject);
    procedure ButtonCheckAlgClick(Sender: TObject);
    procedure ButtongetRandomNumsClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ButtonAboutMeClick(Sender: TObject);
    procedure ButtonAlgClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation
 uses Math;

{$R *.dfm}

//��������������� ������� ��� ��������� ���������� ����� � ������������ ������� Len
function GetRandomStr(Len:Cardinal):string;
var l, i:Cardinal;
begin
 Result:='';
 l:=Random(Len)+1;
 for i:= 1 to l do Result:=Result+IntToStr(Random(9));
end;

//��������������� ������� ��� ��������� ������ ������� Count �� C ��������
function PutChar(C:Char; Count:Cardinal):string;
var i:Cardinal;
begin
 Result:='';
 for i:= 1 to Count do Result:=Result+C;
end;

//��������������� ������� ��� ��������� ������ ������ ������, �������� � ������� ��������� C
function FillStart(S:string; C:Char; Size:UInt64):string;
begin
 if (S.Length >= Size) or (S.Length > 1024) then Exit(S);
 while S.Length < Size do S:=C+S;
 Result:=S;
end;

//��������������� ������� ��� �������������� ������
function InvertStr(Str:string):String;
var i:UInt64;
begin
 i:=Str.Length;
 while i >= 1 do
  begin
   Result:=Result + Str[i];
   Dec(i);
  end;
end;

//��������������� ������� ��� ���������� �������� ������ ����� � ������� �����
procedure IncStr(var Value:string; const Index:UInt64);
begin
 if Index > Value.Length then                            //���� ������ ��������� ����� �����,
  begin                                                  //
   Value:=Value+'1';                                     //�� ������ ����� ��������� ������� � �����
   Exit;                                                 //� �������
  end;                                                   //���� �� ������ �� ��������� �����
 if Value[Index] <> '9' then                             //��, ���� ��� �������� ����� �� 9
  Value[Index]:=IntToStr(StrToInt(Value[Index]) + 1)[1]  //����� �������� � �� ����� ������ �� 1
 else                                                    //� ��������� ������,
  begin                                                  //���� ��� �������� �������,
   Value[Index]:='0';                                    //�� �������� ����� ��� �������� �� 0
   if Index < Value.Length then IncStr(Value, Index + 1) //�, ���� ������ �� ��������� ����� ����� ��������� � �������� ��� ����������� ������� ���������� ��������
   else Value:=Value+'1';                                //� ��������� ������, ������ ��������� ����� ������� � �����
  end;
end;

//�������� ������� ������������ ������� �����
function Summ(Str1, Str2:string):string;
var S1, S2, S3:string;
  i: UInt64;
begin
 Result:='';                                          //���������� - ������
 if Str1.Length > Str2.Length then                    //��� ���������� ���������
  begin                                               //����� ������� ����� � S1,
   S1:=InvertStr(Str1);                               //� �������� � S2
   S2:=InvertStr(Str2);                               //������������ � ����
  end                                                 //�������������� ����� (������)
 else                                                 //��� ��� ����, ����� ����
  begin                                               //�� ����� ������� �� ����� S2
   S1:=InvertStr(Str2);                               //
   S2:=InvertStr(Str1);                               //
  end;
 i:=1;
 while i <= S2.Length do                              //�������� ������ �� S2
  begin                                               //
   S3:=IntToStr(StrToInt(S1[i])+StrToInt(S2[i]));     //S3 - ��� ����� ���� ����� �� ������� ��������
   if S3.Length > 1 then                              //���� ���������� ���������� ����� (�������� 6+5 > 11)
    begin                                             //� ���������� ���������� ������ ����� �� �����;
     Result:=Result+S3[2];                            //������ - ��� �������
     IncStr(S1, i + 1);                               //����� �� ����������� ��������� ����� � S1
    end                                               //���� �� � ��� ���������� ����� �� 1 �� 9,
   else Result:=Result+S3;                            //�� ������ ��������� ��� � ����������
   Inc(i);
  end;                                                //
 S1:=InvertStr(S1);                                   //����������� ����� S1, �.�. �� ��� �������� � ��������
 Result:=InvertStr(Result);                           //������������� ����� ���� ����������� �������
 Result:=Copy(S1, 1, S1.Length - S2.Length) + Result; //�� � � �����, ��������� � ���������� �� �����, ������� ���� �� �������� ����������� (������ ����)
 //�������� � ��� ����� 746232 � 8976 (����� = 755208)
 //S1 ����� 232647, � S2 - 6798; ���������, ��� ������� ��� ����, ����� ���� ���������� �� ����� ������
 //�������� ��� �������� ��� 746232
 //                         +  8976
 //74 - ��� ��� ��� ����� �� �������� ����������� ����� (S2)
 //� ������������ ��������� �� ��� ���: 232647
 //                                      6798
 //���������� 2 � 6, ��������  8 (Result = 8)
 //���������� 3 � 7, �������� 10 (Result = 80), ������. ����. ����� � S1 (S1 = 233647)
 //���������� 3 � 9, �������� 12 (Result = 802), ������. ����. ����� � S1 (S1 = 233747)
 //���������� 7 � 8, �������� 15 (Result = 8025), ������. ����. ����� � S1 (S1 = 233757)
 //��, ���� �������; ������������� S1 (S1 = 757332) � Result (Result = 5208)
 //��������� � Result ����� �� �������� ����� �� S1 (Result = 755208)
end;

procedure TFormMain.ButtonAboutMeClick(Sender: TObject);
begin
 Memo3.Text:='����� ���������: �������� ������� 2015 �.';
// ShowMessage('����� ���������: �������� ������� 2015 �.');
end;

procedure TFormMain.ButtonAlgClick(Sender: TObject);
var RS: TResourceStream;
begin
 RS:=TResourceStream.Create(hInstance, 'Alg', RT_RCDATA);
 Memo3.Lines.Clear;
 Memo3.Lines.LoadFromStream(RS);
 RS.Free;
end;

procedure TFormMain.ButtonCheckAlgClick(Sender: TObject);
var V1, V2, V3:UInt64;
 i:Integer;
 Res:string;
begin
 for i:= 1 to 1000 do
  begin
   V1:=StrToUInt64(GetRandomStr(18));
   V2:=StrToUInt64(GetRandomStr(18));
   Res:=Summ(UIntToStr(V1), UIntToStr(V2));
   V3:=V1+V2;
   if V3 <> (StrToUInt64(Res)) then ShowMessage(UIntToStr(V1)+' + '+UIntToStr(V2)+' ?');
   Memo3.Lines.Add(UIntToStr(V1)+' + '+UIntToStr(V2)+' = '+Res);
  end;
end;

procedure TFormMain.ButtongetRandomNumsClick(Sender: TObject);
begin
 Edit1.Text:=GetRandomStr(StrToInt(EditRndSz.Text));
 Edit2.Text:=GetRandomStr(StrToInt(EditRndSz.Text));
end;

procedure TFormMain.ButtonSumClick(Sender: TObject);
var Res, N:string;
    Size:UInt64;
    Freeze:Cardinal;
begin
 Freeze:=GetTickCount;
 Res:=Summ(Edit1.Text, Edit2.Text);
 Freeze:=GetTickCount - Freeze;
 Size:=Res.Length + 1;
 Memo3.Lines.Clear;
 Memo3.Lines.Add(FillStart(Edit1.Text, ' ', Size));
 N:=FillStart(Edit2.Text, ' ', Size);
 N[1]:='+';
 Memo3.Lines.Add(N);
 Memo3.Lines.Add(PutChar('-', Min(Size, 1024)));
 Memo3.Lines.Add(FillStart(Res, ' ', Size));
 Memo3.Lines.Add('');
 Memo3.Lines.Add(Format('���������� %d-������� �����', [Size - 1]));
 Memo3.Lines.Add(Format('����� ��������: %d ����.', [Freeze]));
end;

procedure TFormMain.Edit1Change(Sender: TObject);
begin
 (Sender as TEdit).Hint:='���� � �����: '+IntToStr(Length((Sender as TEdit).Text));
end;

end.
