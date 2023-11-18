// 5 kyu, 3 yr

using System;
using System.Collections.Generic;
using System.Linq;

public class Kata
{
  private static IEnumerable<int> MoveZeroes(IEnumerable<int> li)
  {
    if (!li.Any()) return li;
    if (li.ElementAt(0) == 0) return MoveZeroes(li.Skip(1)).Append(0);
    return MoveZeroes(li.Skip(1)).Prepend(li.ElementAt(0));
  }

  public static int[] MoveZeroes(int[] arr)
    => MoveZeroes(arr.AsEnumerable()).ToArray();
}