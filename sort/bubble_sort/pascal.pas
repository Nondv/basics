type IntArray = Array of Integer;

Function copyArray(arr : IntArray) : IntArray;
var
   i   : Integer;
   result : IntArray;
begin
   setLength(result, length(arr));

   for i := 0 to length(arr) - 1 do begin
      result[i] := arr[i];
   end;

   copyArray := result;
end;

Function bubbleSort(arr : IntArray) : IntArray;
var
   i, j, tmp : Integer;
   result    : IntArray;

begin
   result := copyArray(arr);

   for i := 0 to length(result) - 1 do begin
      for j := 1 to length(result) - 1 - i do begin
         if result[j - 1] > result[j] then begin
            tmp := result[j];
            result[j] := result[j - 1];
            result[j - 1] := tmp;
         end
      end
   end;

   bubbleSort := result;
end;


var
   a : IntArray;
   i : Integer;
begin
   randomize;

   setLength(a, 10);
   for i := 0 to 9 do begin
      a[i] := random(10);
      write(a[i], ' ');
   end;
   writeLn;

   a := bubbleSort(a);
   for i := 0 to 9 do begin
      write(a[i], ' ');
   end;
   writeLn;
end.

