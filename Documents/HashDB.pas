program DB;
const n = 32; c=3;
type ht = array[0..n] of ^pos;
	pos = record
		id:integer;
		name:string;
		flag:boolean;//false - firstly
	end;
	_pos = record
		place:integer;//_ difference is saving index in ht
		id:integer;
		name:string;
		flag:boolean;
	end;
HDB = file of _pos; //hashed data base
var a:ht; pp:pos; f:HDB; s,inp:string; 
//_ means using db without hash function
//useful when you need to interact with file

function h1(i:integer): integer; begin h1 := i mod n end;
function h2(i:integer): integer; begin h2 := (i+c) mod n end;

procedure prPos( p:pos);
begin
    write('id: ');
    write(p.id);
    write(' | name: ');
    writeln(p.name);
end;

function newPos(i:integer;s:string):pos;//create pos from int(id), str(name)
var g:pos;
begin
    g.id:=i;
    g.name:=s;
    g.flag:=false;
    newPos:=g;
end;

function get(var t:ht; i: integer): pos;//return position from table
var p:pos; k:integer;
begin
    p:=newPos(0,'');
    k:=h1(i);
    //writeln(k);
    if t[k]=nil then writeln('nothing(') else begin 
    p:=t[k]^;
    //prPos(p);
    while p.flag <> true do begin k:=h2(k); p:=t[k]^ end;
    end;
    get:=p;

end;

function __get(var t:ht; i: integer): _pos;//return position from table
var p:pos; k:integer;_p:_pos;
begin
    p:=newPos(0,'');
    k:=h1(i);
    //writeln(k);
    if t[k]=nil then writeln('nothing(') else begin 
    p:=t[k]^;
    //prPos(p);
    while p.flag <> true do begin k:=h2(k); p:=t[k]^ end;
    end;
    _p.place:=k;
    _p.name:=p.name;
    _p.flag:=p.flag;
    _p.id:=p.id;
    __get:=_p;

end;
function _get(var t:ht; i: integer): pos;//return position from table
begin
    if t[i]=nil then writeln('nothing(') else
    _get:=t[i]^;
end;

function to_pos(p:pos;k:integer):_pos;
var g:_pos;
begin
    g.place:=k;
    g.id:=p.id;
    g.name:=p.name;
    g.flag:=p.flag;
    to_pos:=g;
end;

procedure put(var t:ht; p:pos);
var key:integer; g:^pos;
begin
    key:=h1(p.id);
    g:=t[key];
    while g<> nil do begin 
		t[key]^.flag:=false; key:=h2(key); g:=t[key]; writeln(key); 
	end;
    new(g);
    g^.id:=p.id;
    g^.name:=p.name;
    g^.flag:=true;    
    t[key]:=g;
end;

procedure _put(var t:ht; p:_pos);
begin    
    new(t[p.place]);
    t[p.place]^.id:=p.id;
    t[p.place]^.name:=p.name;
end;

procedure deStruct(var t:ht);//dispose hashTable from RAM
var k:integer;
begin
    for k := 0 to n do if t[k]<>nil then dispose(t[k]);
end;

procedure prStruct(var t:ht);
var k:integer;
begin
    for k := 0 to n do
    begin
        write('In ');
        write(k);
        writeln(': ');
        if t[k]<>nil then prPos(t[k]^)
        else writeln('nothing O_O')
    end;
end;

procedure delCell(var t:ht;key:integer );//clear chosen cell of table, don`t use hFuncs
begin
    if t[key]<>nil then begin dispose(t[key]); t[key]:=nil end;
end;

procedure delPos(var t:ht;i:integer );//find pos in table with hFuncs
var key:integer;
begin
    //__get(t,i);
    delCell(t,__get(t,i).place);
    //if t[key]<>nil then begin dispose(t[key]); t[key]:=nil end;
end;

procedure svStruct(var m:HDB; var t:ht);
var k:integer;
begin
    rewrite(m);
    for k := 0 to n do 
    if t[k]<>nil then write(m,to_pos(t[k]^,k));
    close(m);
end;

procedure rdStruct(var m:HDB; var t:ht);
var p:_pos;
begin
    reset(m);
    while not(eof(m))do
    begin
        read(m,p);
        _put(t,p);
    end;
    close(m);
end;

begin
s:='db.txt';
assign(f,s);

//writeln(h1(5));
put(a,newPos(5,'fifth'));
prPos(get(a,5));
put(a,newPos(5,'third'));
prPos(get(a,5));
delPos(a,5);
//delCell(a,5);
put(a,newPos(4,'fourth'));
//write(pp.name);
prStruct(a);
//prPos(get(a,5));
svStruct(f,a);
deStruct(a);
//writeln('now read:)');
rdStruct(f,a);
//prStruct(a);
deStruct(a);
readln(inp);
{while inp<>'exit' do
begin
if inp ='help' then 
begin
writeln('choose &dir');
writeln('add &id &name');
writeln('search &id');
writeln('print');
writeln('save');
writeln('exit');
writeln('del &id');
writeln;
end;
if inp ='print' then 
begin
prStruct(a);
end;
if inp ='save' then 
begin
svStruct(f,a);
writeln('saved');
end;
}

end.
