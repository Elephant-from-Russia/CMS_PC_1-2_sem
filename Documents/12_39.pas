program num1239;
var s,i:integer;
a:array[1..8] of boolean;
b:array[2..16] of boolean;
c:array[-7..7] of boolean;
x:array[1..8]of integer;
d:array[1..8,1..8]of integer;

procedure print; 
var i,j,k:integer;
begin
	s:=s+1;
	writeln('№', s);
	{
	for i:=1 to 8 do
		for j:=1 to 8 do
			d[i,j]:=0;
	for k:=1 to 8 do
		d[8-x[k]+1,k]:=1;
	for i:=1 to 8 do
	begin
		for j:=1 to 8 do
			write(d[i,j]:2);
		writeln;
	end;}
	for i:=1 to 8 do begin
		for j := 1 to 8 do  
			if (8-x[i]+1 = j) then write(1)
			else write(0);
			writeln;
	end;
end;

procedure tr(i:integer);
var j:integer;
begin
	for j:=1 to 8 do
		if a[j] and b[i+j] and c[i-j] then
		begin
			x[i]:=j;
			a[j]:=false; 
			b[i+j]:=false;
			c[i-j]:=false;
			if i<8 then tr(i+1) else print;
				a[j]:=true;
				b[i+j]:=true;
				c[i-j]:=true;
		end;
end;
 
begin
	for i:=1 to 8 do a[i]:=true;
	for i:=2 to 16 do b[i]:=true;
	for i:=-7 to 7 do c[i]:=true;
	s:=0;
	tr(1);
end.
