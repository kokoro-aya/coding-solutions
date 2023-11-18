// 5 kyu, 7 mo

using System;
using System.Linq;
using System.Text.RegularExpressions;

public class DomainNameValidator {
    public bool validate(string domain)
    {
        if (domain.Length > 253) return false;
        var levels = domain.Split('.');
        if (levels.Length < 2) return false;
        if (levels.Length > 127) return false;
        if (levels[^1].All(char.IsNumber)) return false;
        return
            levels
                .Where(level =>
                    level.Length > 0 && level.Length < 63
                )
                .Where(level =>
                    Enumerable.Range('A', 'Z')
                        .Concat(Enumerable.Range('a', 'z'))
                        .Concat(Enumerable.Range('0', '9'))
                        .Contains(level[0])
                )
                .Where(level => Enumerable.Range('A', 'Z')
                    .Concat(Enumerable.Range('a', 'z'))
                    .Concat(Enumerable.Range('0', '9'))
                    .Contains(level[^1]))
                .Count(level => Regex.IsMatch(level, "^[A-Za-z0-9-]*$")) == levels.Length;

    }
}