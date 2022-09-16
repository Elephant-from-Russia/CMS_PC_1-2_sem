program hash;
uses HashTables;
procedure menu;
var f: data;
	t: htable;
	x: elem;
	num, key: integer;

procedure MenuElem;
begin
	read(key);
	if SearchElem(key, t) = N then exit;
	writeln('elem is found');
	writeln('write 1 to see them');
	writeln('write 2 to remove them');
	writeln('write any other number else');
	read(num);
	case num of
		1: PrintElem(SearchElem(key, t), t);
		2: DeleteElem(SearchElem(key, t), t);
	end;
end;

begin
	assign(f, 'HashData');
	InitTable(t, f);
	while true do begin
		writeln('1. Add element');
		writeln('2. Print table');
		writeln('3. Search for element by key');
		writeln('4. Delete element by key');
		writeln('5. Exit');
		writeln('Write number of operation');
		read(num);
		case num of
			1: ReadElem(x, t);
			2: PrintTable(t);
			3: MenuElem;
			4: begin
				write('Write key: ');
				read(key);
				DeleteElem(SearchElem(key, t), t);
			end;
			5: begin
				Save(t, f);
				exit;
			end;
		else writeln('wrong number of operation');
		end;
	end;
end;

begin
	Menu;
end.
