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

//Вспомогательная функция для получения случайного числа с максимальной длинной Len
function GetRandomStr(Len:Cardinal):string;
var l, i:Cardinal;
begin
 Result:='';
 l:=Random(Len)+1;
 for i:= 1 to l do Result:=Result+IntToStr(Random(9));
end;

//Вспомогательная функция для получения строки длинной Count из C символов
function PutChar(C:Char; Count:Cardinal):string;
var i:Cardinal;
begin
 Result:='';
 for i:= 1 to Count do Result:=Result+C;
end;

//Вспомогательная функция для получения строки нужной длинны, дополняя её спереди символами C
function FillStart(S:string; C:Char; Size:UInt64):string;
begin
 if (S.Length >= Size) or (S.Length > 1024) then Exit(S);
 while S.Length < Size do S:=C+S;
 Result:=S;
end;

//Вспомогательная функция для инвертирования строки
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

//Вспомогательная функция для увеличения отдельно взятой цифры в длинном числе
procedure IncStr(var Value:string; const Index:UInt64);
begin
 if Index > Value.Length then                            //Если индекс привышает длину числа,
  begin                                                  //
   Value:=Value+'1';                                     //то просто сразу добавляем десяток к числу
   Exit;                                                 //и выходим
  end;                                                   //Если же индекс не привышает длину
 if Value[Index] <> '9' then                             //То, если под индексом цифра не 9
  Value[Index]:=IntToStr(StrToInt(Value[Index]) + 1)[1]  //тогда заменяем её на цифру больше на 1
 else                                                    //в противном случае,
  begin                                                  //если под индексом девятка,
   Value[Index]:='0';                                    //То заменяем число под индексом на 0
   if Index < Value.Length then IncStr(Value, Index + 1) //и, если индекс не превышает длину числа переходим в рекурсию для дальнейшего повтора увеличения значения
   else Value:=Value+'1';                                //В противном случае, просто добавляем новый десяток к числу
  end;
end;

//Основная функция суммирования длинных чисел
function Summ(Str1, Str2:string):string;
var S1, S2, S3:string;
  i: UInt64;
begin
 Result:='';                                          //Приступаем - чистим
 if Str1.Length > Str2.Length then                    //Нам необходимо поместить
  begin                                               //самое длинное число в S1,
   S1:=InvertStr(Str1);                               //а короткое в S2
   S2:=InvertStr(Str2);                               //Одновременно с этим
  end                                                 //переворачиваем число (строку)
 else                                                 //Это для того, чтобы идти
  begin                                               //по циклу линейно по числу S2
   S1:=InvertStr(Str2);                               //
   S2:=InvertStr(Str1);                               //
  end;
 i:=1;
 while i <= S2.Length do                              //Проходим циклом по S2
  begin                                               //
   S3:=IntToStr(StrToInt(S1[i])+StrToInt(S2[i]));     //S3 - это сумма двух чисел на текущей итерации
   if S3.Length > 1 then                              //Если получилось двузначное число (например 6+5 > 11)
    begin                                             //К результату подставлем вторую цифру из суммы;
     Result:=Result+S3[2];                            //первая - это десяток
     IncStr(S1, i + 1);                               //Далее мы увеличиваем следующую цифру в S1
    end                                               //Если же у нас получилось число от 1 до 9,
   else Result:=Result+S3;                            //то просто добавляем его к результату
   Inc(i);
  end;                                                //
 S1:=InvertStr(S1);                                   //Инвертируем число S1, т.к. мы его изменяли в процессе
 Result:=InvertStr(Result);                           //Резултирующее число тоже инвертируем обратно
 Result:=Copy(S1, 1, S1.Length - S2.Length) + Result; //Ну и в конце, добавляем к результату те цифры, которые были за границей наименьшего (поясню ниже)
 //Например у нас числа 746232 и 8976 (сумма = 755208)
 //S1 будет 232647, а S2 - 6798; Повторюсь, это сделано для того, чтобы идти равномерно по обеим числам
 //Выглядит это примерно так 746232
 //                         +  8976
 //74 - это как раз числа за границей наименьшего числа (S2)
 //В перевернутом состоянии мы идём так: 232647
 //                                      6798
 //Складываем 2 и 6, получаем  8 (Result = 8)
 //Складываем 3 и 7, получаем 10 (Result = 80), увелич. след. число в S1 (S1 = 233647)
 //Складываем 3 и 9, получаем 12 (Result = 802), увелич. след. число в S1 (S1 = 233747)
 //Складываем 7 и 8, получаем 15 (Result = 8025), увелич. след. число в S1 (S1 = 233757)
 //Всё, цикл окончен; Переворачивем S1 (S1 = 757332) и Result (Result = 5208)
 //Добавляем к Result числа за границей длины из S1 (Result = 755208)
end;

procedure TFormMain.ButtonAboutMeClick(Sender: TObject);
begin
 Memo3.Text:='Автор программы: Геннадий Малинин 2015 г.';
// ShowMessage('Автор программы: Геннадий Малинин 2015 г.');
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
 Memo3.Lines.Add(Format('Получилось %d-значное число', [Size - 1]));
 Memo3.Lines.Add(Format('Время рассчета: %d мсек.', [Freeze]));
end;

procedure TFormMain.Edit1Change(Sender: TObject);
begin
 (Sender as TEdit).Hint:='Цифр в числе: '+IntToStr(Length((Sender as TEdit).Text));
end;

end.
