using ExoAI.API.DTO.Authentication;

namespace ExoAI.API.Service;

public interface IAuthService
{
	Task<UserResponse?> LoginAsync(string email, string password, CancellationToken cancellationToken = default);
	//Task<UserResponse?> GetRefreshTokenAsync(string token, string refreshToken, CancellationToken cancellationToken = default);
	Task<UserResponse> RegisterAsync(RegisterRequest request, CancellationToken cancellationToken = default);
}

