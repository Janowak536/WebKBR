using System;
using System.Collections.Generic;

public partial class ClientsOrder
{
    public int ClientId { get; set; }

    public int OrderId { get; set; }

    public DateTime OrderDate { get; set; }

    public decimal OrderValue { get; set; }

    public virtual Client Client { get; set; } = null!;

    public virtual Order Order { get; set; } = null!;
}
