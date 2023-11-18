// 5 kyu, 3 yr

using System;
using System.Collections.Generic;
using System.Linq;

public class Kata
{
  private static IEnumerable<char> Iterate(string str)
  {
    for (int i = 0; i < str.Length; i++)
    {
      yield return str[i];
      if (i == str.Length - 1)
      {
        i = -1;
      }
    }
  }

  public static Func<char> MakeLooper(string str)
  {
    var iteratee = Iterate(str);
    return () =>
    {
      var ch = iteratee.First();
      iteratee = iteratee.Skip(1);
      return ch;
    };
  }
}