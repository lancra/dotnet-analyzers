namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    "StyleCop.CSharp.OrderingRules",
    "SA1204:Static elements should appear before instance elements",
    Justification = "Operators are defined in the same order as the rule help page.")]
#pragma warning disable CS0660 // Required to surface CA2225 in all scenarios.
public sealed class CA2225(int value)
#pragma warning restore CS0660 // Type defines operator == or operator != but does not override Object.Equals(object o)
{
    public int Value { get; private set; } = value;

    public static CA2225 operator +(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return new(left.Value + right.Value);
    }

    public void operator +=(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        Value += operand.Value;
    }

    public static CA2225 operator &(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return new(left.Value & right.Value);
    }

    public void operator &=(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        Value &= operand.Value;
    }

    public static CA2225 operator |(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return new(left.Value | right.Value);
    }

    public void operator |=(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        Value |= operand.Value;
    }

    public static CA2225 operator --(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        return new(operand.Value - 1);
    }

    public static CA2225 operator /(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return new(left.Value / right.Value);
    }

    public void operator /=(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        Value /= operand.Value;
    }

    public static bool operator ==(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return left.Value == right.Value;
    }

    public static CA2225 operator ^(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return new(left.Value ^ right.Value);
    }

    public void operator ^=(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        Value ^= operand.Value;
    }

    public static bool operator >(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return left.Value > right.Value;
    }

    public static bool operator >=(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return left.Value >= right.Value;
    }

    public static CA2225 operator ++(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        return new(operand.Value + 1);
    }

    public static bool operator !=(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return left.Value != right.Value;
    }

    public static CA2225 operator <<(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return new(left.Value << right.Value);
    }

    public void operator <<=(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        Value <<= operand.Value;
    }

    public static bool operator <(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return left.Value < right.Value;
    }

    public static bool operator <=(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return left.Value <= right.Value;
    }

    public static bool operator !(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        return false;
    }

    public static CA2225 operator %(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return new(left.Value % right.Value);
    }

    public void operator %=(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        Value %= operand.Value;
    }

    public static CA2225 operator *(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return new(left.Value * right.Value);
    }

    public void operator *=(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        Value *= operand.Value;
    }

    public static CA2225 operator ~(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        return new(~operand.Value);
    }

    public static CA2225 operator >>(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return new(left.Value >> right.Value);
    }

    public void operator >>=(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        Value >>= operand.Value;
    }

    public static CA2225 operator -(CA2225 left, CA2225 right)
    {
        ArgumentNullException.ThrowIfNull(left);
        ArgumentNullException.ThrowIfNull(right);
        return new(left.Value - right.Value);
    }

    public void operator -=(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        Value -= operand.Value;
    }

    public static bool operator true(CA2225 operand)
        => true;

    public static CA2225 operator -(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        return new(operand.Value * -1);
    }

    public static CA2225 operator +(CA2225 operand)
    {
        ArgumentNullException.ThrowIfNull(operand);
        return new(operand.Value);
    }

    public static bool operator false(CA2225 operand)
        => false;

    public override int GetHashCode() => base.GetHashCode();
}
