using System;
using Newtonsoft.Json;

namespace OpbeansDotnet.Model
{
	public class Order
	{
		public long Id { get; set; }

		[JsonProperty("customer_id")] public long CustomerId { get; set; }

		[JsonProperty("customer_name")] public string CustomerName { get; set; }

		public DateTime CreatedAt { get; set; }
	}
}
