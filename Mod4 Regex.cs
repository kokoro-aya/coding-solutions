// 5 kyu, 3 yr

using System.Text.RegularExpressions;
public class Mod
{
    public static Regex MOD4 = new Regex(@"^[^\[]*\[{1}[+-]?([0-9]*([13579]{1}[26]{1}|[24680]{1}[048]{1})|0|4|8)\]{1}.*$");
}