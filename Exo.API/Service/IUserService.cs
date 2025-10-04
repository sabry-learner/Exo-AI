using ExoAI.API.DTO.Authentication;

namespace ExoAI.API.Service;

public interface IUserService
{
	Task<UserProfile> GetProfileAsync(string userId, CancellationToken cancellationToken = default);
}
