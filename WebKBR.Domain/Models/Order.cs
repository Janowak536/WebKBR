using System;
using System.Collections.Generic;


public partial class Order
{
    public int OrderId { get; set; }

    public int ModelId { get; set; }

    public int ColorId { get; set; }

    public int MdfId { get; set; }

    public decimal TotalValue { get; set; }

    public virtual Color Color { get; set; } = null!;

    public virtual Mdf Mdf { get; set; } = null!;

    public virtual Model Model { get; set; } = null!;
}
