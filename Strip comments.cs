// 4 kyu, 3 yr

using System.Linq;
using System.Text.RegularExpressions;
public class StripCommentsSolution
{
    
  public static string StripOneLine(string line, string[] symbols)
    => string.Concat(line.TakeWhile(e => !symbols.Contains($"{e}"))).TrimEnd();

  public static string StripComments(string text, string[] commentSymbols)
    => string.Join('\n', text.Split("\n")
       .Select(l => StripOneLine(l, commentSymbols)));
}