// This file is part of YamlDotNet - A .NET library for YAML.
// Copyright (c) 2013 aaubry
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

using System;
using System.Collections.Generic;
using System.Reflection;
using YamlDotNet.Core;
using YamlDotNet.Core.Events;

namespace YamlDotNet.RepresentationModel.Serialization.NodeDeserializers
{
	public sealed class GenericDictionaryNodeDeserializer : INodeDeserializer
	{
		private readonly IObjectFactory _objectFactory;

		public GenericDictionaryNodeDeserializer(IObjectFactory objectFactory)
		{
			_objectFactory = objectFactory;
		}
	
		bool INodeDeserializer.Deserialize(EventReader reader, Type expectedType, Func<EventReader, Type, object> nestedObjectDeserializer, out object value)
		{
			var iDictionary = ReflectionUtility.GetImplementedGenericInterface(expectedType, typeof(IDictionary<,>));
			if (iDictionary == null)
			{
				value = false;
				return false;
			}

			reader.Expect<MappingStart>();

			value = _objectFactory.Create(expectedType);
			_deserializeHelperMethod
				.MakeGenericMethod(iDictionary.GetGenericArguments())
				.Invoke(null, new object[] { reader, expectedType, nestedObjectDeserializer, value });

			reader.Expect<MappingEnd>();

			return true;
		}

		private static MethodInfo _deserializeHelperMethod = typeof(GenericDictionaryNodeDeserializer)
			.GetMethod("DeserializeHelper", BindingFlags.Static | BindingFlags.NonPublic);

		private static void DeserializeHelper<TKey, TValue>(EventReader reader, Type expectedType, Func<EventReader, Type, object> nestedObjectDeserializer, IDictionary<TKey, TValue> result)
		{
			while (!reader.Accept<MappingEnd>())
			{
				var key = (TKey)nestedObjectDeserializer(reader, typeof(TKey));
				var value = (TValue)nestedObjectDeserializer(reader, typeof(TValue));
				result.Add(key, value);
			}
		}
	}
}
