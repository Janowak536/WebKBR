using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using WebKBR.Domain.Models;

namespace WebKBR.Infrastructure;

public partial class Db2kbrContext : DbContext
{
    public Db2kbrContext()
    {
    }

    public Db2kbrContext(DbContextOptions<Db2kbrContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Client> Clients { get; set; }

    public virtual DbSet<Color> Colors { get; set; }

    public virtual DbSet<Mdf> Mdfs { get; set; }

    public virtual DbSet<Model> Models { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=DESKTOP-0URS1MD;Database=db_2kbr;Trusted_Connection=True;TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Client>(entity =>
        {
            entity.HasKey(e => e.ClientId).HasName("PK__Clients__E67E1A0450B329C4");

            entity.HasIndex(e => e.Username, "UQ__Clients__536C85E44EDB3DC9").IsUnique();

            entity.Property(e => e.ClientId).HasColumnName("ClientID");
            entity.Property(e => e.Address)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.City)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.ClientType)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.DiscountCode)
                .HasMaxLength(20)
                .IsUnicode(false);
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
                .IsFixedLength();
            entity.Property(e => e.UserRole).HasMaxLength(20);
            entity.Property(e => e.Username).HasMaxLength(256);
        });

        modelBuilder.Entity<Color>(entity =>
        {
            entity.HasKey(e => e.ColorId).HasName("PK__Colors__8DA7676DB6F2CD24");

            entity.Property(e => e.ColorId)
                .ValueGeneratedNever()
                .HasColumnName("ColorID");
            entity.Property(e => e.ColorName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.Type)
                .HasMaxLength(20)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.Value).HasColumnType("decimal(15, 2)");
        });

        modelBuilder.Entity<Mdf>(entity =>
        {
            entity.HasKey(e => e.MdfId).HasName("PK__MDF__1D29DD2BA8D2C6BD");

            entity.ToTable("MDF");

            entity.Property(e => e.MdfId)
                .ValueGeneratedNever()
                .HasColumnName("MdfID");
            entity.Property(e => e.MdfName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.Type)
                .HasMaxLength(20)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.Value).HasColumnType("decimal(15, 2)");
        });

        modelBuilder.Entity<Model>(entity =>
        {
            entity.HasKey(e => e.ModelId).HasName("PK__Models__E8D7A1CCE3D855E3");

            entity.Property(e => e.ModelId).HasColumnName("ModelID");
            entity.Property(e => e.ModelName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.Type)
                .HasMaxLength(20)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.Value).HasColumnType("decimal(15, 2)");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.ProductId).HasName("PK__Orders__B40CC6ED476D7E2C");

            entity.Property(e => e.ProductId).HasColumnName("ProductID");
            entity.Property(e => e.ClientId).HasColumnName("ClientID");
            entity.Property(e => e.ColorId).HasColumnName("ColorID");
            entity.Property(e => e.MdfId).HasColumnName("MdfID");
            entity.Property(e => e.ModelId).HasColumnName("ModelID");
            entity.Property(e => e.OrderId).HasColumnName("OrderID");
            entity.Property(e => e.OrderValue).HasColumnType("decimal(20, 2)");

            entity.HasOne(d => d.Client).WithMany(p => p.Orders)
                .HasForeignKey(d => d.ClientId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Orders__ClientID__2D27B809");

            entity.HasOne(d => d.Color).WithMany(p => p.Orders)
                .HasForeignKey(d => d.ColorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Orders__ColorID__2F10007B");

            entity.HasOne(d => d.Mdf).WithMany(p => p.Orders)
                .HasForeignKey(d => d.MdfId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Orders__MdfID__300424B4");

            entity.HasOne(d => d.Model).WithMany(p => p.Orders)
                .HasForeignKey(d => d.ModelId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Orders__ModelID__2E1BDC42");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
