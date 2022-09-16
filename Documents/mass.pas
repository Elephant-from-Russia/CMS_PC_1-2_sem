procedure hashtable;
const N = 255
type mas = array[1..N] of integer;
	list = ^ node
	node = record 
		elem: integer;
		next: lsit end;

procedure build(var A:mas; var e:list);
procedure build_dop(var A:mas; var e: list; k: integer);
var a :list;
begin 
	if k > 0 then begin
		new(q);
		q^.elem := A[k];
		q^.next := e;
		e := q;
		build_dop(A,e,k-1);
	end;
end;

begin
	e := nil;
	build_dop(A, e, N)
end;

