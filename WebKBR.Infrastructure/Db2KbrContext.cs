using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

public partial class Db2KbrContext : DbContext
{
    public Db2KbrContext()
    {
    }

    public Db2KbrContext(DbContextOptions<Db2KbrContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Client> Clients { get; set; }

    public virtual DbSet<ClientsOrder> ClientsOrders { get; set; }

    public virtual DbSet<Color> Colors { get; set; }

    public virtual DbSet<Mdf> Mdfs { get; set; }

    public virtual DbSet<Model> Models { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=DESKTOP-0URS1MD;Database=db_2kbr;Trusted_Connection=True;TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Client>(entity =>
        {
            entity.HasKey(e => e.ClientId).HasName("PK__Clients__81A2CB818E546450");

            entity.HasIndex(e => e.DiscountCode, "UQ__Clients__3D87979AF178DF29").IsUnique();

            entity.HasIndex(e => e.Phone, "UQ__Clients__5C7E359E627C7ECE").IsUnique();

            entity.HasIndex(e => e.Email, "UQ__Clients__A9D1053475D1B40B").IsUnique();

            entity.HasIndex(e => e.Nip, "UQ__Clients__C7DEC3C6E1EC6C28").IsUnique();

            entity.Property(e => e.ClientId).HasColumnName("clientID");
            entity.Property(e => e.Address)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.City)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.ClientType)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("clientType");
            entity.Property(e => e.DiscountCode)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("discountCode");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Nip)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("NIP");
            entity.Property(e => e.Phone)
                .HasMaxLength(11)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.PostalCode)
                .HasMaxLength(6)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("postalCode");
        });

        modelBuilder.Entity<ClientsOrder>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("clientsOrders");

            entity.HasIndex(e => e.OrderId, "UQ__clientsO__0809337C8271E302").IsUnique();

            entity.Property(e => e.ClientId).HasColumnName("clientID");
            entity.Property(e => e.OrderDate)
                .HasColumnType("date")
                .HasColumnName("orderDate");
            entity.Property(e => e.OrderId).HasColumnName("orderID");
            entity.Property(e => e.OrderValue)
                .HasColumnType("decimal(15, 2)")
                .HasColumnName("orderValue");

            entity.HasOne(d => d.Client).WithMany()
                .HasForeignKey(d => d.ClientId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__clientsOr__clien__3A81B327");

            entity.HasOne(d => d.Order).WithOne()
                .HasForeignKey<ClientsOrder>(d => d.OrderId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__clientsOr__order__3B75D760");
        });

        modelBuilder.Entity<Color>(entity =>
        {
            entity.HasKey(e => e.ColorId).HasName("PK__Colors__70A64C3D147A70FB");

            entity.Property(e => e.ColorId)
                .ValueGeneratedNever()
                .HasColumnName("colorID");
            entity.Property(e => e.ColorName)
                .HasMaxLength(20)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("colorName");
            entity.Property(e => e.Type)
                .HasMaxLength(20)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.WorthValue)
                .HasColumnType("decimal(15, 2)")
                .HasColumnName("worthValue");
        });

        modelBuilder.Entity<Mdf>(entity =>
        {
            entity.HasKey(e => e.MdfId).HasName("PK__MDF__35C49AC2EE4C1934");

            entity.ToTable("MDF");

            entity.Property(e => e.MdfId)
                .ValueGeneratedNever()
                .HasColumnName("mdfID");
            entity.Property(e => e.MdfName)
                .HasMaxLength(20)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("mdfName");
            entity.Property(e => e.Type)
                .HasMaxLength(20)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.WorthValue)
                .HasColumnType("decimal(15, 2)")
                .HasColumnName("worthValue");
        });

        modelBuilder.Entity<Model>(entity =>
        {
            entity.HasKey(e => e.ModelId).HasName("PK__Models__0215CDB9E41C0F0B");

            entity.Property(e => e.ModelId).HasColumnName("modelID");
            entity.Property(e => e.ModelName)
                .HasMaxLength(20)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("modelName");
            entity.Property(e => e.Type)
                .HasMaxLength(20)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.WorthValue)
                .HasColumnType("decimal(15, 2)")
                .HasColumnName("worthValue");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.OrderId).HasName("PK__Orders__0809337D83F2914D");

            entity.Property(e => e.OrderId).HasColumnName("orderID");
            entity.Property(e => e.ColorId).HasColumnName("colorID");
            entity.Property(e => e.MdfId).HasColumnName("mdfID");
            entity.Property(e => e.ModelId).HasColumnName("modelID");
            entity.Property(e => e.TotalValue)
                .HasColumnType("decimal(20, 2)")
                .HasColumnName("totalValue");

            entity.HasOne(d => d.Color).WithMany(p => p.Orders)
                .HasForeignKey(d => d.ColorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Orders__colorID__36B12243");

            entity.HasOne(d => d.Mdf).WithMany(p => p.Orders)
                .HasForeignKey(d => d.MdfId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Orders__mdfID__37A5467C");

            entity.HasOne(d => d.Model).WithMany(p => p.Orders)
                .HasForeignKey(d => d.ModelId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Orders__modelID__35BCFE0A");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__Users__1788CCACD239DF25");

            entity.Property(e => e.UserId).HasColumnName("UserID");
            entity.Property(e => e.ClientId).HasColumnName("ClientID");
            entity.Property(e => e.Email).HasMaxLength(256);

            entity.HasOne(d => d.Client).WithMany(p => p.Users)
                .HasForeignKey(d => d.ClientId)
                .HasConstraintName("FK__Users__ClientID__32E0915F");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
