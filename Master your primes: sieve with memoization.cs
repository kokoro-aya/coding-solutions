// 5 kyu, 3 yr

using System;
using System.Collections.Generic;
class Kata
{
  public static List<long> Primes { get; } = new List<long> { 2, 3, 5, 7 };
  private static void ExpandPrimes(long lastPrime)
  {
    for (var i = lastPrime / 6 * 6;; i += 6)
    {
      if (i + 1 > lastPrime && IsPrime(i + 1))
      {
        Primes.Add(i + 1);
        return;
      }

      if (i + 5 > lastPrime && IsPrime(i + 5))
      {
        Primes.Add(i + 5);
        return;
      }
    }
  }

  public static bool IsPrime(long n)
  {
    if (n < 2) return false;
    var limit = Math.Round(Math.Sqrt(n));
    for (int i = 0; ; i++)
    {
      if (i >= Primes.Count) ExpandPrimes(Primes[i - 1]);
      if (Primes[i] > limit) break;
      if (n % Primes[i] == 0) return false;
    }
    return true;
  }
}