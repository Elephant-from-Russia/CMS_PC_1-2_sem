program body;

uses hash;

var
	f : file of node;
	x : node;
	kluch : keys;
	emp : 1..3;
	nam : string;
	m : tab;
	num, i, am : integer;
	kk : keys;
begin
	assign(f, 'res');
	reset(f);
	ini(m);
		while not eof(f) do
			begin
				{read(f, kluch);
				read(f, nam);
				read(f, am);
				read(f, emp);}
				read(f, x);
				{x.key := kluch;
				x.empty := emp;
				x.inf.name := naml
				x.inf.amount := am;}
				add12(m, x);
			end;
	close(f);
	while true do
		begin
			writeln ('What do you want to do? Type a number from 1 to 5.');
			writeln ('1) Add an element to the hash table.');
			writeln ('2) Delete the element from the hash table.');
			writeln ('3) Find the element from the hash table');
			writeln ('4) Print content of the hash table');
			writeln ('5) Shutdown');
			read(num);
			if (num < 1) or (num > 5) then
				begin
					writeln('Unnacceptable input. Please write a number from 1 to 5.');
					continue;
				end;
			if (num = 1) then
				begin
					writeln('Type in this order: key, name, amount');
					add(m);
					continue;
				end;
			if (num = 2) then
				begin
					writeln('Type the key of element, which you want to delete');
					read(kk);
					del(m, kk);
					continue;
				end;
			if (num = 3) then
				begin
					writeln('Type the key of element, which you want to find');
					read(kk);
					find(m, kk);
					continue;
				end;
			if (num = 4) then
				begin
					print(m);
					continue;
				end;
			if (num = 5) then
				begin
					rewrite(f);
					for i := 1 to n do
						begin
							if (m[i].empty = 2) then
								begin
									{writeln(f, m[i].key);
									writeln(f, m[i].inf.name);
									write(f, m[i].inf.amount, ' ');
									writeln(f, m[i].empty);}
									write(f, m[i]);
								end;
						end;
					break;
				end;
		end;
	writeln('Goodbye');
	close(f);
end.
