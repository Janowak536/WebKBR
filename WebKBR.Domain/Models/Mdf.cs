using System;
using System.Collections.Generic;

namespace WebKBR.Domain.Models;

public partial class Mdf
{
    public int MdfId { get; set; }

    public string? MdfName { get; set; }

    public string? Type { get; set; }

    public decimal? Value { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
