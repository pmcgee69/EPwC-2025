unit U_BinaryCounterReduction;


interface

procedure Min_12_main;


implementation

uses  System.Math, System.Generics.Collections, System.Sysutils;

const crlf = #13#10;

type  TOp  = TFunc<integer,integer,integer>;


function least(x,y:integer):integer;   begin  result := ifthen(x<y, x, y);  end;


procedure Add(carry:integer; const Cmp:TOp);
begin
      for var i := 1 to counter.Count do begin
           if counter[i] = 0 then begin
                                     counter[i] := carry;
                                     carry   := 0;
                                     break;
                                  end;
           carry := Cmp(counter[i], carry);
           counter[i] := 0;
      end;
      if carry <> 0 then counter.Add(carry);
end;


function reduce(const Cmp:TOp):integer;
begin
      if counter.Count = 0 then exit(0);

      result := counter[1];
      for var c in counter do
           if c<>0 then result := Cmp(c, result);
end;



const
      data0 : TArray<integer> = [9, 13, 7, 124, 32, 17, 8, 32, 237, 417, 41, 42, 13, 14, 15];


function Apply_Op_Twice( Op:TOp ) : TPair<integer,integer>;
begin
      for var d in data do add(d, Op);
      var x1 := reduce(Op);

      data.Remove(x1); counter.Clear;

      for var d in data do add(d, Op);
      var x2 := reduce(Op);

      result := TPair<integer,integer>.Create(x1,x2);
end;


procedure Min_12_main;
begin
      var counter := TCollections.CreateList<integer>;
      var data    := TCollections.CreateList<integer>(data0);

      var x := Apply_Op_twice( least );
      writeln('Min : ', x.Key, crlf, 'Min : ', x.Value);
end;


end.


