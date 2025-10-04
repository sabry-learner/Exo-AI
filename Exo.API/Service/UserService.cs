using ExoAI.API.DTO.Authentication;
using ExoAI.API.Persistence;

namespace ExoAI.API.Service;

public class UserService : IUserService
{
	private readonly ApplicationDbContext _context;

	public UserService(ApplicationDbContext context)
	{
		_context = context;
	}

	public async Task<UserProfile> GetProfileAsync(string userId, CancellationToken cancellationToken = default)
	{
		var user = await _context.Users.FindAsync(userId, cancellationToken);

		if (user is null)
			throw new ArgumentException("User not found");

		return new UserProfile(user.Id, user.Email!, user.FirstName, user.LastName);
	}
}
