﻿using System;
using System.Collections.Generic;

namespace WebKBR.Domain.Models;

public partial class Color
{
    public int ColorId { get; set; }

    public string? ColorName { get; set; }

    public string? Type { get; set; }

    public decimal? Value { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
