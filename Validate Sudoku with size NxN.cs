// 4 kyu, 3 yr

using System;
using System.Collections.Generic;
using System.Linq;

class Sudoku
{
  private IEnumerable<IEnumerable<int>> Chess;
  private int Dim;
  private List<int> PreparedList;

  public Sudoku(int[][] sudokuData)
  {
    Chess = sudokuData.Select(e => e.ToList()).ToList();
    Dim = Chess.Count();
    PreparedList = Enumerable.Range(1, Dim).ToList();
  }

  private bool Match(List<int> a, List<int> b)
  {
    a.Sort();
    b.Sort();
    return a.Zip(b).Select(e => e.First == e.Second).Aggregate((e, f) => e && f);
  }

  private bool ValidateRows()
    => Chess.Select(e => Match(e.ToList(), PreparedList)).Aggregate((e, f) => e && f);

  private bool ValidateColumns()
  {
    for (var i = 0; i < Dim; i++)
    {
      var li = new List<int>();
      for (var j = 0; j < Dim; j++)
      {
        li.Add(Chess.ElementAt(j).ElementAt(i));
      }
      if (!Match(li, PreparedList))
        return false;
    }
    return true;
  }

  private bool ValidateSubSquare(int n, int m)
  {
    var N = Convert.ToInt32(Math.Sqrt(Dim));
    var li = new List<int>();
    for (var i = m * N; i < (m + 1) * N; i++)
    {
      for (var j = n * N; j < (n + 1) * N; j++)
      {
        li.Add(Chess.ElementAt(i).ElementAt(j));
      }

    }
    return Match(li, PreparedList);
  }

  private IEnumerable<Tuple<int, int>> GeneratePossibleRanges(int n)
  {
    for (var i = 0; i < n; i++)
      for (var j = 0; j < n; j++)
        yield return new Tuple<int, int>(i, j);
  }

  private bool ValidateAllSquares()
    => GeneratePossibleRanges(Convert.ToInt32(Math.Sqrt(Dim)))
    .Select(e => ValidateSubSquare(e.Item1, e.Item2))
    .Aggregate((e, f) => e && f);

  public bool IsValid()
  {
    if (Dim < 1) return false;
    if (Chess.Select(e => e.Count()).Any(e => e != Dim)) return false;
    // A squared array with size == Dim > 0
    return ValidateRows() && ValidateColumns() && ValidateAllSquares();
  }
}