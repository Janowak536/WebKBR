using System;
using System.Collections.Generic;

namespace WebKBR.Domain.Models;

public partial class Model
{
    public int ModelId { get; set; }

    public string? ModelName { get; set; }

    public string? Type { get; set; }

    public decimal? Value { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
