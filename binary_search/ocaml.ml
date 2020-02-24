type search_result =
  | Found of int
  | NotFound

let b_search array value =
  let rec aux left right =
    if left > right then
      NotFound
    else
      let mid = left + (right - left) / 2 in
      if array.(mid) = value then
        Found mid
      else
        if array.(mid) < value then
          aux (mid + 1) right
        else
          aux left (mid - 1)
  in
  aux 0 ((Array.length array) - 1)


let test expected actual =
  if expected = actual then
    print_string "pass"
  else
    print_string "FAIL"

let () =
  test (Found 0) (b_search [|3|] 3);
  test (Found 2) (b_search [|1; 2; 3|] 3);
  test (Found 1) (b_search [|4; 5; 6|] 5);
  test NotFound (b_search [|4; 5; 6|] 1);
  test NotFound (b_search [|4; 5; 6|] 9);
  test NotFound (b_search [|4; 5; 10|] 7);
  test NotFound (b_search [||] 7);
  test NotFound (b_search [|1|] 7);
