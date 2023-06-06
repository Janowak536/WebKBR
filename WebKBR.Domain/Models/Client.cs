using System;
using System.Collections.Generic;


public partial class Client
{
    public int ClientId { get; set; }

    public string? Name { get; set; }

    public string? NIP { get; set; }

    public string? Phone { get; set; }

    public string? Email { get; set; }

    public string? Address { get; set; }

    public string? City { get; set; }

    public string? PostalCode { get; set; }

    public string? ClientType { get; set; }

    public string? DiscountCode { get; set; }

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
