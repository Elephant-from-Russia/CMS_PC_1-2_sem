Unit HashTables;
interface
	const N=5; C=1;
	type
		elem = record
		key: 0..maxint;
		info: record
				author: string[20];
				title: string[20];
			end;
		end;
		htable = array[0..N-1] of elem;
		data = file of elem;

{сделать таблицу пустой}
procedure InitTable(var t: htable; var f: data);
{добавление элемента в хеш-таблицу}
procedure AddElem(var x: elem; var t: htable);
{распечатать элементы хеш-таблицы}
procedure PrintTable(var t: htable);
{поиск элемента в хеш-таблице по ключу}
function SearchElem(key: integer; var t: htable): integer;
{распечатать указанный элемент хеш-таблицы}
procedure PrintElem(i: integer; var t: htable);
{удаление элемента с помощью ket}
procedure DeleteElem(i: integer; var t: htable);
{чтение элемента из ввода}
procedure ReadElem(var x: elem; var t: htable);
{сохранение данных перед выходом}
procedure Save(var t: htable; var f: data);

implementation

procedure Save(var t: htable; var f: data);
var i: integer;
begin
	rewrite(f);
	for i:=0 to N-1 do
		if t[i].key <> 0 then write(f, t[i]);
	close(f);
end;

procedure DeleteElem(i: integer; var t: htable);
var buff, k: integer;
begin
	if i = N then exit;
	buff:=(i + C) mod N;
	k:=1;
	while k <> N do
	begin
		if t[buff].key mod N <> buff then
		begin
			t[i]:=t[buff];
			i:=buff;
		end 
		else if t[i].key mod N = buff then break;
		buff:=(buff + C) mod N;
		k:=k+1;
	end;
	t[i].key:=0;
end;

procedure PrintElem(i: integer; var t: htable);
begin
	writeln('i:',i, '; key: ',t[i].key, '; author: ', t[i].info.author, '; title: ', t[i].info.title);
end;

function SearchElem(key: integer; var t: htable): integer;
var i: integer;
begin
	i:=key mod N;
	repeat
		if t[i].key = key then
		begin
			SearchElem:=i;
			exit;
		end 
		else i:=(i+C) mod N;
	until i = key mod N;
	SearchElem:=N;
	writeln('Element not found');
end;

procedure PrintTable(var t: htable);
var i: integer;
begin
	for i:=0 to N-1 do
	if t[i].key <> 0 then PrintElem(i, t);
end;

procedure InitTable(var t: htable; var f: data );
var i: integer;
	x: elem;
begin
	for i:=0 to N-1 do t[i].key:=0;
	reset(f);
	while not eof(f) do
	begin
		read(f, x);
		AddElem(x, t);
	end;
end;

procedure AddElem(var x: elem; var t: htable);
var i: integer;
begin
	if (x.key < 1) then
	begin
		writeln('wrong key');
		exit;
	end;
	i:=x.key mod N;
	repeat
		if t[i].key = 0 then
		begin
			t[i]:=x;
			exit;
		end;
		i:=(i + C) mod N;
	until i = x.key mod N;
	if i = x.key mod N then writeln('table is overflow');
end;

procedure ReadElem(var x: elem; var t: htable);
begin
	readln(x.key);
	readln(x.info.author);
	readln(x.info.title);
	AddElem(x, t)
end;
end.
