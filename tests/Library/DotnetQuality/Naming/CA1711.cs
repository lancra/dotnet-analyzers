using System.Collections;
using System.Data;
using System.Diagnostics.CodeAnalysis;
using System.Security;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Naming;

[SuppressMessage(
    "Design",
    "CA1010:Generic interface should also be implemented",
    Justification = "Non-generic interfaces are implemented independently to surface this rule across various scenarios.")]
[SuppressMessage(
    "Design",
    "CA1034:Nested types should not be visible",
    Justification = "Multiple public types are required to surface this rule across various scenarios.")]
[SuppressMessage(
    "Design",
    "CA1058:Types should not extend certain base types",
    Justification = "Non-generic interfaces are implemented independently to surface this rule across various scenarios.")]
[SuppressMessage(
    "Naming",
    "CA1710:Identifiers should have correct suffix",
    Justification = "Overlaps with this rule.")]
public static class CA1711
{
    [AttributeUsage(AttributeTargets.All)]
    public sealed class OneCollection : Attribute
    {
    }

    public class TwoAttribute : EventArgs
    {
    }

    public class ThreeEventArgs : Exception
    {
        public ThreeEventArgs(string message)
            : base(message)
        {
        }

        public ThreeEventArgs(string message, Exception innerException)
            : base(message, innerException)
        {
        }
    }

    public class FourAttribute(ICollection collection) : ICollection
    {
        private readonly ICollection _collection = collection;

        public int Count => _collection.Count;

        public bool IsSynchronized => _collection.IsSynchronized;

        public object SyncRoot => _collection.SyncRoot;

        public void CopyTo(Array array, int index) => _collection.CopyTo(array, index);

        public IEnumerator GetEnumerator() => _collection.GetEnumerator();
    }

    public class FiveException(IDictionary dictionary) : IDictionary
    {
        private readonly IDictionary _dictionary = dictionary;

        public bool IsFixedSize => _dictionary.IsFixedSize;

        public bool IsReadOnly => _dictionary.IsReadOnly;

        public ICollection Keys => _dictionary.Keys;

        public ICollection Values => _dictionary.Values;

        public int Count => _dictionary.Count;

        public bool IsSynchronized => _dictionary.IsSynchronized;

        public object SyncRoot => _dictionary.SyncRoot;

        public object? this[object key] { get => _dictionary[key]; set => _dictionary[key] = value; }

        public void Add(object key, object? value) => _dictionary.Add(key, value);

        public void Clear() => _dictionary.Clear();

        public bool Contains(object key) => _dictionary.Contains(key);

        public void CopyTo(Array array, int index) => _dictionary.CopyTo(array, index);

        public IDictionaryEnumerator GetEnumerator() => _dictionary.GetEnumerator();

        public void Remove(object key) => _dictionary.Remove(key);

        IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();
    }

    public class SixPermission(IEnumerable enumerable) : IEnumerable
    {
        private readonly IEnumerable _enumerable = enumerable;

        public IEnumerator GetEnumerator() => _enumerable.GetEnumerator();
    }

    public class SevenAttribute<TKey, TValue>(IReadOnlyDictionary<TKey, TValue> dictionary) : IReadOnlyDictionary<TKey, TValue>
    {
        private readonly IReadOnlyDictionary<TKey, TValue> _dictionary = dictionary;

        public IEnumerable<TKey> Keys => _dictionary.Keys;

        public IEnumerable<TValue> Values => _dictionary.Values;

        public int Count => _dictionary.Count;

        public TValue this[TKey key] => _dictionary[key];

        public bool ContainsKey(TKey key) => _dictionary.ContainsKey(key);

        public IEnumerator<KeyValuePair<TKey, TValue>> GetEnumerator() => _dictionary.GetEnumerator();

        public bool TryGetValue(TKey key, [MaybeNullWhen(false)] out TValue value) => _dictionary.TryGetValue(key, out value);

        IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();
    }

    public class EightStack : Queue
    {
    }

    public class NineStream<T> : Queue<T>
    {
    }

    public class TenQueue : Stack
    {
    }

    public class ElevenEventHandler<T> : Stack<T>
    {
    }

    public class TwelveException<T>(ICollection<T> collection) : ICollection<T>
    {
        private readonly ICollection<T> _collection = collection;

        public int Count => _collection.Count;

        public bool IsReadOnly => _collection.IsReadOnly;

        public void Add(T item) => _collection.Add(item);

        public void Clear() => _collection.Clear();

        public bool Contains(T item) => _collection.Contains(item);

        public void CopyTo(T[] array, int arrayIndex) => _collection.CopyTo(array, arrayIndex);

        public IEnumerator<T> GetEnumerator() => _collection.GetEnumerator();

        public bool Remove(T item) => _collection.Remove(item);

        IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();
    }

    public class ThirteenStack<TKey, TValue>(IDictionary<TKey, TValue> dictionary) : IDictionary<TKey, TValue>
    {
        private readonly IDictionary<TKey, TValue> _dictionary = dictionary;

        public ICollection<TKey> Keys => _dictionary.Keys;

        public ICollection<TValue> Values => _dictionary.Values;

        public int Count => _dictionary.Count;

        public bool IsReadOnly => _dictionary.IsReadOnly;

        public TValue this[TKey key] { get => _dictionary[key]; set => _dictionary[key] = value; }

        public void Add(TKey key, TValue value) => _dictionary.Add(key, value);

        public void Add(KeyValuePair<TKey, TValue> item) => _dictionary.Add(item);

        public void Clear() => _dictionary.Clear();

        public bool Contains(KeyValuePair<TKey, TValue> item) => _dictionary.Contains(item);

        public bool ContainsKey(TKey key) => _dictionary.ContainsKey(key);

        public void CopyTo(KeyValuePair<TKey, TValue>[] array, int arrayIndex) => _dictionary.CopyTo(array, arrayIndex);

        public IEnumerator<KeyValuePair<TKey, TValue>> GetEnumerator() => _dictionary.GetEnumerator();

        public bool Remove(TKey key) => _dictionary.Remove(key);

        public bool Remove(KeyValuePair<TKey, TValue> item) => _dictionary.Remove(item);

        public bool TryGetValue(TKey key, [MaybeNullWhen(false)] out TValue value) => _dictionary.TryGetValue(key, out value);

        IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();
    }

    public class FourteenCollection : DataSet
    {
    }

    public class FifteenAttribute : DataTable
    {
    }

    public class SixteenEventArgs(Stream stream) : Stream
    {
        private readonly Stream _stream = stream;

        public override bool CanRead => _stream.CanRead;

        public override bool CanSeek => _stream.CanSeek;

        public override bool CanWrite => _stream.CanWrite;

        public override long Length => _stream.Length;

        public override long Position { get => _stream.Position; set => _stream.Position = value; }

        public override void Flush() => _stream.Flush();

        public override int Read(byte[] buffer, int offset, int count) => _stream.Read(buffer, offset, count);

        public override long Seek(long offset, SeekOrigin origin) => _stream.Seek(offset, origin);

        public override void SetLength(long value) => _stream.SetLength(value);

        public override void Write(byte[] buffer, int offset, int count) => _stream.Write(buffer, offset, count);

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _stream?.Dispose();
            }

            base.Dispose(disposing);
        }
    }

#pragma warning disable SYSLIB0003 // Type or member is obsolete
    public class SeventeenDictionary(IPermission permission) : IPermission
    {
        private readonly IPermission _permission = permission;

        public IPermission Copy() => _permission.Copy();

        public void Demand() => _permission.Demand();

        public void FromXml(SecurityElement e) => _permission.FromXml(e);

        public IPermission? Intersect(IPermission? target) => _permission.Intersect(target);

        public bool IsSubsetOf(IPermission? target) => _permission.IsSubsetOf(target);

        public SecurityElement? ToXml() => _permission.ToXml();

        public IPermission? Union(IPermission? target) => _permission.Union(target);
    }
#pragma warning restore SYSLIB0003
}
