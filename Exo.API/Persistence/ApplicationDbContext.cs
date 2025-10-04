using ExoAI.API.Entities;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System.Reflection;

namespace ExoAI.API.Persistence;

public class ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
	: IdentityDbContext<ApplicationUser>(options)
{
	public DbSet<Upload> Uploads { set; get; }
	public DbSet<Model> Models { get; set; }
	public DbSet<Prediction> Predictions { set; get; }
	public DbSet<Log> Logs { set; get; }

	protected override void OnModelCreating(ModelBuilder modelBuilder)
	{
		modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());

		modelBuilder.Entity<Upload>(entity =>
		{
			entity.Property(u => u.Status).HasConversion<string>();
			entity.HasOne(e => e.User)
				  .WithMany()
				  .HasForeignKey(e => e.UserId)
				  .IsRequired(false);
		});

		// Models configuration
		modelBuilder.Entity<Model>(entity =>
		{
			entity.HasKey(e => e.Id);
			entity.Property(e => e.Id).ValueGeneratedOnAdd();
			entity.Property(e => e.Version).HasMaxLength(50);
			entity.Property(e => e.Accuracy).HasPrecision(5, 4);
			entity.Property(e => e.TrainedOn).HasColumnType("nvarchar(max)");
			entity.Property(e => e.UpdatedAt).HasDefaultValueSql("GETDATE()");
			entity.HasOne(e => e.User)
				  .WithMany()
				  .HasForeignKey(e => e.UserId)
				  .IsRequired(false);
		});

		modelBuilder.Entity<Prediction>(entity =>
		{
			entity.HasKey(e => e.Id);
			entity.Property(e => e.Id).ValueGeneratedOnAdd();
			entity.Property(e => e.Class).HasConversion<string>();
			entity.Property(e => e.Confidence).HasPrecision(5, 4);
			entity.Property(e => e.Features).HasColumnType("nvarchar(max)");
			entity.Property(e => e.PredictedAt).HasDefaultValueSql("GETDATE()");
			entity.HasOne(e => e.Upload)
				  .WithMany()
				  .HasForeignKey(e => e.UploadId);
		});

		modelBuilder.Entity<Log>(entity =>
		{
			entity.HasKey(e => e.Id);
			entity.Property(e => e.Id).ValueGeneratedOnAdd();
			entity.Property(e => e.Action).HasMaxLength(100);
			entity.Property(e => e.Timestamp).HasDefaultValueSql("GETDATE()");
			entity.Property(e => e.Details).HasColumnType("nvarchar(max)");
			entity.HasOne(e => e.User)
				  .WithMany()
				  .HasForeignKey(e => e.UserId);
		});

		modelBuilder.Entity<ApplicationUser>(entity =>
		{
			//entity.Property(e => e.Role).HasConversion<string>();
			entity.Property(e => e.CreatedAt).HasDefaultValueSql("GETDATE()");
		});

		base.OnModelCreating(modelBuilder);
	}
}