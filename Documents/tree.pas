program tree;

type 
	tree = ^Tnode;
	Tnode = record
			elem: integer;
		left, right: tree;

function max(t: tree) : integer;
var k,k1:integer;
begin
	if (t^.left = nil) and (l^.right = nil) then max := t^.elem
	else
		begin 
			k:= max(t^left)l
			if k>t^.elem then max := k
		end;
	if t^.right <> nil then
		begin
			k := max(t^.right);
			if k>k1 then k1 := k;
		end
	max := k1;
end;

function colrer(t: tree; n: integer):integer;






