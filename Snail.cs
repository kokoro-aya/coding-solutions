// 4 kyu, 3 yr

using System;
using System.Collections.Generic;
using System.Linq;

public static class SnailSolution
{
  public static List<List<T>> ArrayToList<T>(this T[][] array)
  {
    return array.Select(x => x.ToList()).ToList();
  }

  public enum Direction
  {
    TOP, BOTTOM, LEFT, RIGHT
    }

  public static int[] Snail(int[][] array)
  {
    var chess = array.ArrayToList();
    var stack = new List<int>();
    var current = Direction.TOP;
    while (chess.Count != 0)
    {
      switch (current)
      {
        case Direction.TOP:
          {
            var line = chess.First();
            stack.AddRange(line);
            chess.RemoveAt(0);
            current = Direction.RIGHT;
            break;
          }
        case Direction.RIGHT:
          {
            var line = chess.Select(li => li.Last());
            stack.AddRange(line);
            chess.ForEach(li => li.RemoveAt(li.Count - 1));
            chess.RemoveAll(li => li.Count == 0);
            current = Direction.BOTTOM;
            break;
          }
        case Direction.BOTTOM:
          {
            var line = chess.Last();
            line.Reverse();
            stack.AddRange(line);
            chess.RemoveAt(chess.Count - 1);
            current = Direction.LEFT;
            break;
          }
        case Direction.LEFT:
          {
            var line = chess.Select(li => li.First()).Reverse();
            stack.AddRange(line);
            chess.ForEach(li => li.RemoveAt(0));
            chess.RemoveAll(li => li.Count == 0);
            current = Direction.TOP;
            break;
          }
        default:
          throw new Exception("This could not happen.");
      }
    }

    return stack.ToArray();
  }
}