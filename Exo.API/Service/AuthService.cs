using ExoAI.API.DTO.Authentication;
using ExoAI.API.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;

namespace ExoAI.API.Service;

public class AuthService : IAuthService
{
	private readonly UserManager<ApplicationUser> _userManager;
	//private readonly IJwtProvider _jwtProvider;
	public AuthService(UserManager<ApplicationUser> userManager)
	{
		_userManager = userManager;
		//_jwtProvider = jwtProvider;
	}

	//private readonly int _refreshTokenExpiryDays = 14;

	public async Task<UserResponse?> LoginAsync(string email, string password, CancellationToken cancellationToken = default)
	{
		//check user
		var user = await _userManager.FindByEmailAsync(email);

		if (user is null)
			return null;

		//check password
		var isPasswordValid = await _userManager.CheckPasswordAsync(user, password);

		if (!isPasswordValid)
			return null;

		//generate jwt token 
		//var (token, expiresIn) = _jwtProvider.GenerateToken(user);

		//generate refresh token
		//var refreshToken = GenerateRefreshToken();
		//var refreshTokenExpiration = DateTime.UtcNow.AddDays(_refreshTokenExpiryDays);

		//user.RefreshTokens.Add(new RefreshToken
		//{
		//	Token = refreshToken,
		//	ExpiresOn = refreshTokenExpiration
		//});

		//await _userManager.UpdateAsync(user);

		//return user response
		return new UserResponse(user.Id, user.Email, user.FirstName, user.LastName);
	}

	//public async Task<UserResponse?> GetRefreshTokenAsync(string token, string refreshToken, CancellationToken cancellationToken = default)
	//{
	//	var userId = _jwtProvider.ValidateToken(token);

	//	if (userId is null)
	//		return null;

	//	var user = await _userManager.FindByIdAsync(userId);

	//	if (user is null)
	//		return null;

	//	var userRefreshToken = user.RefreshTokens.SingleOrDefault(x => x.Token == refreshToken && x.IsActive);

	//	if (userRefreshToken is null)
	//		return null;

	//	userRefreshToken.RevokedOn = DateTime.UtcNow;

	//	var (newToken, expiresIn) = _jwtProvider.GenerateToken(user);
	//	var newRefreshToken = GenerateRefreshToken();
	//	var refreshTokenExpiration = DateTime.UtcNow.AddDays(_refreshTokenExpiryDays);

	//	user.RefreshTokens.Add(new RefreshToken
	//	{
	//		Token = newRefreshToken,
	//		ExpiresOn = refreshTokenExpiration
	//	});

	//	await _userManager.UpdateAsync(user);

	//	return new UserResponse(user.Id, user.Email, user.FirstName, user.LastName, newToken, expiresIn, newRefreshToken, refreshTokenExpiration);
	//}

	public async Task<UserResponse> RegisterAsync(RegisterRequest request, CancellationToken cancellationToken = default)
	{
		var emailIsExists = await _userManager.Users.AnyAsync(x => x.Email == request.Email, cancellationToken);

		if (emailIsExists)
			throw new Exception("Another user with the same email is already exists.");

		var user = new ApplicationUser
		{
			Email = request.Email,
			UserName = request.Email,
			FirstName = request.FirstName,
			LastName = request.LastName,
			CreatedAt = DateTime.UtcNow
		};

		var result = await _userManager.CreateAsync(user, request.Password);

		if (result.Succeeded)
		{
			//var (token, expiresIn) = _jwtProvider.GenerateToken(user);

			//var refreshToken = GenerateRefreshToken();
			//var refreshTokenExpiration = DateTime.UtcNow.AddDays(_refreshTokenExpiryDays);

			//user.RefreshTokens.Add(new RefreshToken
			//{
			//	Token = refreshToken,
			//	ExpiresOn = refreshTokenExpiration
			//});

			//await _userManager.UpdateAsync(user);

			return new UserResponse(user.Id, user.Email, user.FirstName, user.LastName);

		}

		var error = result.Errors.First();
		throw new Exception(error.Description);
	}

	//private static string GenerateRefreshToken()
	//{
	//	return Convert.ToBase64String(RandomNumberGenerator.GetBytes(64));
	//}
}
