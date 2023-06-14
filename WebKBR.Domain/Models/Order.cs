using System;
using System.Collections.Generic;

namespace WebKBR.Domain.Models;

public partial class Order
{
    public int ProductId { get; set; }

    public int ClientId { get; set; }

    public int OrderId { get; set; }

    public int ModelId { get; set; }

    public int ColorId { get; set; }

    public int MdfId { get; set; }

    public short Width { get; set; }

    public short Height { get; set; }

    public decimal OrderValue { get; set; }

    public virtual Client Client { get; set; } = null!;

    public virtual Color Color { get; set; } = null!;

    public virtual Mdf Mdf { get; set; } = null!;

    public virtual Model Model { get; set; } = null!;
}
