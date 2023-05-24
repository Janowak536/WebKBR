using System;
using System.Collections.Generic;

public partial class User
{
    public int UserId { get; set; }

    public string Username { get; set; } = null!;

    public string PasswordHash { get; set; } = null!;

    public int? ClientId { get; set; }

    public virtual Client? Client { get; set; }
}
