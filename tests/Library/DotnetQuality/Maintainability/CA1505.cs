namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Maintainability;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "Maintainability",
    "CA1502:Avoid excessive complexity",
    Justification = "This is a side effect of producing an unmaintainable method.")]
internal sealed class CA1505
{
    public static int ComplexCalculation(int a, int b, bool flag, string text, DateTime date)
    {
        var result = 0;
        var temp3 = 0;

        if (a > 0)
        {
            if (b > 0)
            {
                if (flag)
                {
                    if (!string.IsNullOrEmpty(text))
                    {
                        if (text.Length > 5)
                        {
                            result += a + b;
                            if (date.DayOfWeek == DayOfWeek.Monday)
                            {
                                result += 10;
                            }
                            else
                            {
                                result -= 5;
                            }
                        }
                        else
                        {
                            result -= a - b;
                        }
                    }
                    else
                    {
                        result += a * b;
                    }
                }
                else
                {
                    if (a % 2 == 0)
                    {
                        result += a * b;
                    }
                    else
                    {
                        result -= b - a;
                    }
                }
            }
            else
            {
                if (flag && text.Length > 3)
                {
                    result += a * 2;
                }
                else
                {
                    result -= a / 2;
                }
            }
        }
        else
        {
            result = b < 0 ? a - b : b - a;
        }

        var temp1 = (a % 3) switch
        {
            0 => a + b,
            1 => a - b,
            _ => a * b,
        };

        var temp2 = (b % 4) switch
        {
            0 => b + a,
            1 => b - a,
            2 => b * a,
            _ => b / (a == 0 ? 1 : a),
        };

        for (var i = 0; i < a; i++)
        {
            for (var j = 0; j < b; j++)
            {
                if ((i + j) % 2 == 0)
                {
                    temp3 += i * j;
                }
                else
                {
                    temp3 -= i + j;
                }
            }
        }

        if (temp1 > temp2)
        {
            if (temp3 > 0)
            {
                result += temp1 + temp3;
            }
            else
            {
                result -= temp2 - temp3;
            }
        }
        else
        {
            if (temp3 < 0)
            {
                result += temp2 - temp3;
            }
            else
            {
                result -= temp1 + temp3;
            }
        }

        for (var k = 0; k < 5; k++)
        {
            switch (k)
            {
                case 0:
                    result += k + temp1;
                    break;
                case 1:
                    result -= k + temp2;
                    break;
                case 2:
                    result *= k + 1;
                    break;
                case 3:
                    result /= k + 1;
                    break;
                default:
                    result ^= k;
                    break;
            }
        }

        for (var k = 4; k >= 0; k--)
        {
            switch (k)
            {
                case 0:
                    result += k + temp1;
                    break;
                case 1:
                    result -= k + temp2;
                    break;
                case 2:
                    result *= k + 1;
                    break;
                case 3:
                    result /= k + 1;
                    break;
                default:
                    result ^= k;
                    break;
            }
        }

        if (a > 0)
        {
            if (b > 0)
            {
                if (flag)
                {
                    if (!string.IsNullOrEmpty(text))
                    {
                        if (text.Length > 5)
                        {
                            result += a + b;
                            if (date.DayOfWeek == DayOfWeek.Monday)
                            {
                                result += 10;
                            }
                            else
                            {
                                result -= 5;
                            }
                        }
                        else
                        {
                            result -= a - b;
                        }
                    }
                    else
                    {
                        result += a * b;
                    }
                }
                else
                {
                    if (a % 2 == 0)
                    {
                        result += a * b;
                    }
                    else
                    {
                        result -= b - a;
                    }
                }
            }
            else
            {
                if (flag && text.Length > 3)
                {
                    result += a * 2;
                }
                else
                {
                    result -= a / 2;
                }
            }
        }
        else
        {
            result = b < 0 ? a - b : b - a;
        }

        temp1 = (a % 3) switch
        {
            0 => a + b,
            1 => a - b,
            _ => a * b,
        };

        temp2 = (b % 4) switch
        {
            0 => b + a,
            1 => b - a,
            2 => b * a,
            _ => b / (a == 0 ? 1 : a),
        };

        for (var i = 0; i < a; i++)
        {
            for (var j = 0; j < b; j++)
            {
                if ((i + j) % 2 == 0)
                {
                    temp3 += i * j;
                }
                else
                {
                    temp3 -= i + j;
                }
            }
        }

        if (temp1 > temp2)
        {
            if (temp3 > 0)
            {
                result += temp1 + temp3;
            }
            else
            {
                result -= temp2 - temp3;
            }
        }
        else
        {
            if (temp3 < 0)
            {
                result += temp2 - temp3;
            }
            else
            {
                result -= temp1 + temp3;
            }
        }

        for (var k = 0; k < 5; k++)
        {
            switch (k)
            {
                case 0:
                    result += k + temp1;
                    break;
                case 1:
                    result -= k + temp2;
                    break;
                case 2:
                    result *= k + 1;
                    break;
                case 3:
                    result /= k + 1;
                    break;
                default:
                    result ^= k;
                    break;
            }
        }

        for (var k = 4; k >= 0; k--)
        {
            switch (k)
            {
                case 0:
                    result += k + temp1;
                    break;
                case 1:
                    result -= k + temp2;
                    break;
                case 2:
                    result *= k + 1;
                    break;
                case 3:
                    result /= k + 1;
                    break;
                default:
                    result ^= k;
                    break;
            }
        }

        if (a > 0)
        {
            if (b > 0)
            {
                if (flag)
                {
                    if (!string.IsNullOrEmpty(text))
                    {
                        if (text.Length > 5)
                        {
                            result += a + b;
                            if (date.DayOfWeek == DayOfWeek.Monday)
                            {
                                result += 10;
                            }
                            else
                            {
                                result -= 5;
                            }
                        }
                        else
                        {
                            result -= a - b;
                        }
                    }
                    else
                    {
                        result += a * b;
                    }
                }
                else
                {
                    if (a % 2 == 0)
                    {
                        result += a * b;
                    }
                    else
                    {
                        result -= b - a;
                    }
                }
            }
            else
            {
                if (flag && text.Length > 3)
                {
                    result += a * 2;
                }
                else
                {
                    result -= a / 2;
                }
            }
        }
        else
        {
            result = b < 0 ? a - b : b - a;
        }

        temp1 = (a % 3) switch
        {
            0 => a + b,
            1 => a - b,
            _ => a * b,
        };

        temp2 = (b % 4) switch
        {
            0 => b + a,
            1 => b - a,
            2 => b * a,
            _ => b / (a == 0 ? 1 : a),
        };

        for (var i = 0; i < a; i++)
        {
            for (var j = 0; j < b; j++)
            {
                if ((i + j) % 2 == 0)
                {
                    temp3 += i * j;
                }
                else
                {
                    temp3 -= i + j;
                }
            }
        }

        if (temp1 > temp2)
        {
            if (temp3 > 0)
            {
                result += temp1 + temp3;
            }
            else
            {
                result -= temp2 - temp3;
            }
        }
        else
        {
            if (temp3 < 0)
            {
                result += temp2 - temp3;
            }
            else
            {
                result -= temp1 + temp3;
            }
        }

        for (var k = 0; k < 5; k++)
        {
            switch (k)
            {
                case 0:
                    result += k + temp1;
                    break;
                case 1:
                    result -= k + temp2;
                    break;
                case 2:
                    result *= k + 1;
                    break;
                case 3:
                    result /= k + 1;
                    break;
                default:
                    result ^= k;
                    break;
            }
        }

        for (var k = 4; k >= 0; k--)
        {
            switch (k)
            {
                case 0:
                    result += k + temp1;
                    break;
                case 1:
                    result -= k + temp2;
                    break;
                case 2:
                    result *= k + 1;
                    break;
                case 3:
                    result /= k + 1;
                    break;
                default:
                    result ^= k;
                    break;
            }
        }

        if (a > 0)
        {
            if (b > 0)
            {
                if (flag)
                {
                    if (!string.IsNullOrEmpty(text))
                    {
                        if (text.Length > 5)
                        {
                            result += a + b;
                            if (date.DayOfWeek == DayOfWeek.Monday)
                            {
                                result += 10;
                            }
                            else
                            {
                                result -= 5;
                            }
                        }
                        else
                        {
                            result -= a - b;
                        }
                    }
                    else
                    {
                        result += a * b;
                    }
                }
                else
                {
                    if (a % 2 == 0)
                    {
                        result += a * b;
                    }
                    else
                    {
                        result -= b - a;
                    }
                }
            }
            else
            {
                if (flag && text.Length > 3)
                {
                    result += a * 2;
                }
                else
                {
                    result -= a / 2;
                }
            }
        }
        else
        {
            result = b < 0 ? a - b : b - a;
        }

        temp1 = (a % 3) switch
        {
            0 => a + b,
            1 => a - b,
            _ => a * b,
        };

        temp2 = (b % 4) switch
        {
            0 => b + a,
            1 => b - a,
            2 => b * a,
            _ => b / (a == 0 ? 1 : a),
        };

        for (var i = 0; i < a; i++)
        {
            for (var j = 0; j < b; j++)
            {
                if ((i + j) % 2 == 0)
                {
                    temp3 += i * j;
                }
                else
                {
                    temp3 -= i + j;
                }
            }
        }

        if (temp1 > temp2)
        {
            if (temp3 > 0)
            {
                result += temp1 + temp3;
            }
            else
            {
                result -= temp2 - temp3;
            }
        }
        else
        {
            if (temp3 < 0)
            {
                result += temp2 - temp3;
            }
            else
            {
                result -= temp1 + temp3;
            }
        }

        for (var k = 0; k < 5; k++)
        {
            switch (k)
            {
                case 0:
                    result += k + temp1;
                    break;
                case 1:
                    result -= k + temp2;
                    break;
                case 2:
                    result *= k + 1;
                    break;
                case 3:
                    result /= k + 1;
                    break;
                default:
                    result ^= k;
                    break;
            }
        }

        for (var k = 4; k >= 0; k--)
        {
            switch (k)
            {
                case 0:
                    result += k + temp1;
                    break;
                case 1:
                    result -= k + temp2;
                    break;
                case 2:
                    result *= k + 1;
                    break;
                case 3:
                    result /= k + 1;
                    break;
                default:
                    result ^= k;
                    break;
            }
        }

        if (a > 0)
        {
            if (b > 0)
            {
                if (flag)
                {
                    if (!string.IsNullOrEmpty(text))
                    {
                        if (text.Length > 5)
                        {
                            result += a + b;
                            if (date.DayOfWeek == DayOfWeek.Monday)
                            {
                                result += 10;
                            }
                            else
                            {
                                result -= 5;
                            }
                        }
                        else
                        {
                            result -= a - b;
                        }
                    }
                    else
                    {
                        result += a * b;
                    }
                }
                else
                {
                    if (a % 2 == 0)
                    {
                        result += a * b;
                    }
                    else
                    {
                        result -= b - a;
                    }
                }
            }
            else
            {
                if (flag && text.Length > 3)
                {
                    result += a * 2;
                }
                else
                {
                    result -= a / 2;
                }
            }
        }
        else
        {
            result = b < 0 ? a - b : b - a;
        }

        temp1 = (a % 3) switch
        {
            0 => a + b,
            1 => a - b,
            _ => a * b,
        };

        temp2 = (b % 4) switch
        {
            0 => b + a,
            1 => b - a,
            2 => b * a,
            _ => b / (a == 0 ? 1 : a),
        };

        for (var i = 0; i < a; i++)
        {
            for (var j = 0; j < b; j++)
            {
                if ((i + j) % 2 == 0)
                {
                    temp3 += i * j;
                }
                else
                {
                    temp3 -= i + j;
                }
            }
        }

        if (temp1 > temp2)
        {
            if (temp3 > 0)
            {
                result += temp1 + temp3;
            }
            else
            {
                result -= temp2 - temp3;
            }
        }
        else
        {
            if (temp3 < 0)
            {
                result += temp2 - temp3;
            }
            else
            {
                result -= temp1 + temp3;
            }
        }

        for (var k = 0; k < 5; k++)
        {
            switch (k)
            {
                case 0:
                    result += k + temp1;
                    break;
                case 1:
                    result -= k + temp2;
                    break;
                case 2:
                    result *= k + 1;
                    break;
                case 3:
                    result /= k + 1;
                    break;
                default:
                    result ^= k;
                    break;
            }
        }

        for (var k = 4; k >= 0; k--)
        {
            switch (k)
            {
                case 0:
                    result += k + temp1;
                    break;
                case 1:
                    result -= k + temp2;
                    break;
                case 2:
                    result *= k + 1;
                    break;
                case 3:
                    result /= k + 1;
                    break;
                default:
                    result ^= k;
                    break;
            }
        }

        if (a > 0)
        {
            if (b > 0)
            {
                if (flag)
                {
                    if (!string.IsNullOrEmpty(text))
                    {
                        if (text.Length > 5)
                        {
                            result += a + b;
                            if (date.DayOfWeek == DayOfWeek.Monday)
                            {
                                result += 10;
                            }
                            else
                            {
                                result -= 5;
                            }
                        }
                        else
                        {
                            result -= a - b;
                        }
                    }
                    else
                    {
                        result += a * b;
                    }
                }
                else
                {
                    if (a % 2 == 0)
                    {
                        result += a * b;
                    }
                    else
                    {
                        result -= b - a;
                    }
                }
            }
            else
            {
                if (flag && text.Length > 3)
                {
                    result += a * 2;
                }
                else
                {
                    result -= a / 2;
                }
            }
        }
        else
        {
            result = b < 0 ? a - b : b - a;
        }

        temp1 = (a % 3) switch
        {
            0 => a + b,
            1 => a - b,
            _ => a * b,
        };

        temp2 = (b % 4) switch
        {
            0 => b + a,
            1 => b - a,
            2 => b * a,
            _ => b / (a == 0 ? 1 : a),
        };

        for (var i = 0; i < a; i++)
        {
            for (var j = 0; j < b; j++)
            {
                if ((i + j) % 2 == 0)
                {
                    temp3 += i * j;
                }
                else
                {
                    temp3 -= i + j;
                }
            }
        }

        if (temp1 > temp2)
        {
            if (temp3 > 0)
            {
                result += temp1 + temp3;
            }
            else
            {
                result -= temp2 - temp3;
            }
        }
        else
        {
            if (temp3 < 0)
            {
                result += temp2 - temp3;
            }
            else
            {
                result -= temp1 + temp3;
            }
        }

        for (var k = 0; k < 5; k++)
        {
            switch (k)
            {
                case 0:
                    result += k + temp1;
                    break;
                case 1:
                    result -= k + temp2;
                    break;
                case 2:
                    result *= k + 1;
                    break;
                case 3:
                    result /= k + 1;
                    break;
                default:
                    result ^= k;
                    break;
            }
        }

        for (var k = 4; k >= 0; k--)
        {
            switch (k)
            {
                case 0:
                    result += k + temp1;
                    break;
                case 1:
                    result -= k + temp2;
                    break;
                case 2:
                    result *= k + 1;
                    break;
                case 3:
                    result /= k + 1;
                    break;
                default:
                    result ^= k;
                    break;
            }
        }

        return result;
    }
}
