bubble_greatest [] = []
bubble_greatest [x] = [x]
bubble_greatest (x : (y : xs))
        | x > y     = y : (bubble_greatest (x : xs))
        | otherwise = x : (bubble_greatest (y : xs))


bubble_sort xs =
  let reducer semi_sorted _i = bubble_greatest semi_sorted
  in
    foldl reducer xs [1, 2..(length xs)]

bubble_sort2 [] = []
bubble_sort2 [x] = [x]
bubble_sort2 xs =
  let bubbling = iterate (\f -> f . bubble_greatest) bubble_greatest
      sort = (bubbling)!!((length xs) - 1)
  in
    sort xs
