using System;
using System.Collections.Generic;


public partial class Mdf
{
    public int MdfId { get; set; }

    public string? MdfName { get; set; }

    public string? Type { get; set; }

    public decimal? WorthValue { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
