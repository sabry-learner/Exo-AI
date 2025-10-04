using Microsoft.AspNetCore.Identity;

namespace ExoAI.API.Entities;

public sealed class ApplicationUser : IdentityUser
{
	public string FirstName { get; set; } = string.Empty;
	public string LastName { get; set; } = string.Empty;
	public DateTime CreatedAt { get; set; } // datetime, default GETDATE()
	//public List<RefreshToken> RefreshTokens { get; set; } = [];
}
