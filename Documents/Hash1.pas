unit hash;

interface
	const
		n = 10;
		c = 7;
	type
		keys = 1..maxint;
		information = record
			name : string;
			amount : 1..maxint;
		end;
		node = record
			key : keys;
			empty : 1..3;
			inf : information;
		end;
		tab = array [1..n] of node;
	procedure ini (var m : tab);
	function full (var m : tab) : boolean;
	procedure add (var m : tab);
	procedure add12 (var m : tab; var x : node);
	procedure del (var m : tab; k : keys);
	function find (var m : tab; k : keys) : integer;
	procedure print (var m : tab);
implementation

	procedure ini (var m : tab);
	var
		i : integer;
	begin
		for i := 1 to n do
			m[i].empty := 1;
	end;

	function full (var m : tab) : boolean;
		var
			sum, i : integer;
		begin
			sum := 0;
			for i := 1 to n do
				if  m[i].empty = 2 then
					sum := sum + 1;
			writeln('Total amount of element in the hash table is ', sum);
			full := sum = n - 1;
		end;

	procedure add (var m : tab);
		var
			x : keys;
			am, g : integer;
			nam : string;
		begin
			if (full (m)) then
				writeln('Hash table is already full')
			else
				begin
					g := c;
					readln(x);
					readln(nam);
					readln(am);
					if (m[(x mod n) + 1].empty = 1) or (m[(x mod n) + 1].empty = 3) then
						begin
							{writeln('i = ', (x mod n) + 1);}
							m[(x mod n) + 1].empty := 2;
							m[(x mod n) + 1].key := x;
							m[(x mod n) + 1].inf.name := nam;
							m[(x mod n) + 1].inf.amount := am;
						end
					else
						begin
							while m[((x + g) mod n) + 1].empty = 2 do
								begin
									{writeln('(x + g) mod n + 1 = ', ((x + g) mod n) + 1);}
									g := g + c;
								end;
							{writeln('i = ', ((x + g) mod n) + 1);}
							m[((x + g) mod n) + 1].empty := 2;
							m[((x + g) mod n) + 1].key := x;
							m[((x + g) mod n) + 1].inf.name := nam;
							m[((x + g) mod n) + 1].inf.amount := am;
						end;
				end;
		end;

	procedure add12 (var m : tab; var x : node);
		var
			g : integer;
		begin
			g := c;
			if (m[(x.key mod n) + 1].empty = 1) or (m[(x.key mod n) + 1].empty = 3) then
				begin
					
					m[(x.key mod n) + 1].empty := x.empty;
					m[(x.key mod n) + 1].key := x.key;
					m[(x.key mod n) + 1].inf.name := x.inf.name;
					m[(x.key mod n) + 1].inf.amount := x.inf.amount;
					{m[(x.key mod n) + 1] := x;}
				end
			else
				begin
					while m[((x.key + g) mod n) + 1].empty = 2 do
						g := g + c;
					
					m[((x.key + g) mod n) + 1].empty := x.empty;
					m[((x.key + g) mod n) + 1].key := x.key;
					m[((x.key + g) mod n) + 1].inf.name := x.inf.name;
					m[((x.key + g) mod n) + 1].inf.amount := x.inf.amount;
					{m[((x.key + g) mod n) + 1] := x;}
				end;
			full(m);
		end;

	procedure print (var m : tab);
		var
			i : integer;
		begin
			for i := 1 to n do
				if (m[i].empty = 2) then
					writeln(i, ' ', m[i].key, ' ', m[i].inf.name, ' ', m[i].inf.amount);
		end;
	
	function find (var m : tab; k : keys) : integer;
		var
			g : integer;
		begin
			g := c;
			if (m[(k mod n) + 1].key = k) then
				begin
					if (m[(k mod n) + 1].empty <> 2) then
						begin
							find := -1;
							writeln('The element hasnt found :(');
							exit;
						end;
					writeln(m[(k mod n) + 1].key, ' ', m[(k mod n) + 1].inf.name, ' ', m[(k mod n) + 1].inf.amount);
					find := (k mod n) + 1;
				end
			else
				begin
					while not (k = m[((k + g) mod n) + 1].key) do
						begin
							if (m[((k + g) mod n) + 1].empty = 1) then
								begin
									find := -1;
									writeln('The element hasnt found :(');
									exit;
								end;
							g := g + c;
						end;
					if (m[((k + g) mod n) + 1].empty <> 2) then
						begin
							find := -1;
							writeln('The element hasnt found :(');
							exit;
						end;
					find := ((k + g) mod n) + 1;
					writeln(m[((k + g) mod n) + 1].key, ' ', m[((k + g) mod n) + 1].inf.name, ' ', m[((k + g) mod n) + 1].inf.amount);
				end;
		end;
	procedure del (var m : tab; k : keys);
		var
			i : integer;
		begin
			i := find (m, k);
			if (i <> -1) then
				m[i].empty := 3;
		end;
end.
