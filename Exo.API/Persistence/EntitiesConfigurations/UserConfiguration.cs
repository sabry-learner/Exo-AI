using ExoAI.API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace ExoAI.API.Persistence.EntitiesConfigurations;

public class UserConfiguration : IEntityTypeConfiguration<ApplicationUser>
{
	public void Configure(EntityTypeBuilder<ApplicationUser> builder)
	{
		//builder
		//	.OwnsMany(x => x.RefreshTokens)
		//	.ToTable("RefreshTokens")
		//	.WithOwner()
		//	.HasForeignKey("UserId");

		builder.Property(u => u.FirstName).HasMaxLength(100);
		builder.Property(u => u.LastName).HasMaxLength(100);

	}
}
