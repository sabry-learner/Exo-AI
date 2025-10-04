using ExoAI.API.DTO.Authentication;
using ExoAI.API.Service;
using Microsoft.AspNetCore.Mvc;

namespace ExoAI.API.Controllers;

[Route("[controller]")]
[ApiController]
public class AuthController : ControllerBase
{
	private readonly IAuthService _authService;

	public AuthController(IAuthService authService)
	{
		_authService = authService;
	}
	[HttpPost("login")]
	public async Task<IActionResult> Login([FromBody] LoginRequest request, CancellationToken cancellationToken)
	{
		var userResult = await _authService.LoginAsync(request.Email, request.Password, cancellationToken);

		return userResult is null ? BadRequest("Invalid email/password") : Ok(userResult);
	}

	//[HttpPost("refresh")]
	//public async Task<IActionResult> RefreshToken([FromBody] RefreshTokenRequest request, CancellationToken cancellationToken)
	//{
	//	var userResult = await _authService.GetRefreshTokenAsync(request.Token, request.RefreshToken, cancellationToken);

	//	return userResult is null ? BadRequest("Invalid token") : Ok(userResult);
	//}

	[HttpPost("register")]
	public async Task<IActionResult> Register(RegisterRequest request, CancellationToken cancellationToken)
	{
		try
		{
			var response = await _authService.RegisterAsync(request, cancellationToken);
			return Ok(response);
		}
		catch (Exception ex)
		{
			return BadRequest(new { message = ex.Message });
		}
	}
}