using System;
using System.Collections.Generic;


public partial class Model
{
    public int ModelId { get; set; }

    public string? ModelName { get; set; }

    public string? Type { get; set; }

    public decimal? WorthValue { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
