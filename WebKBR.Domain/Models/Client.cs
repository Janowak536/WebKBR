using System;
using System.Collections.Generic;

namespace WebKBR.Domain.Models;

public partial class Client
{
    public int ClientId { get; set; }

    public string? Name { get; set; }

    public string? Nip { get; set; }

    public string? Phone { get; set; }

    public string? Email { get; set; }

    public string? Address { get; set; }

    public string? City { get; set; }

    public string? PostalCode { get; set; }

    public string? ClientType { get; set; }

    public string? DiscountCode { get; set; }

    public string Username { get; set; } = null!;

    public string PasswordHash { get; set; } = null!;

    public string? UserRole { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
