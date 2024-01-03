using System;
using System.Collections.Generic;

namespace WebKBR.API.WebKBR.Domain.Models;

public partial class OrderStatus
{
    public int OrderStatusId { get; set; }

    public int OrderId { get; set; }

    public string? Status { get; set; }

    public decimal? OrderValue { get; set; }
}
