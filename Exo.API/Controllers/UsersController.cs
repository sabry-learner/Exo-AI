using ExoAI.API.Service;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ExoAI.API.Controllers;
[Route("api/[controller]")]
[ApiController]
//[Authorize]
public class UsersController : ControllerBase
{
	private readonly IUserService _userService;

	public UsersController(IUserService userService)
	{
		_userService = userService;
	}

	[HttpGet("profile/{userId}")]
	public async Task<IActionResult> GetProfile([FromRoute] string userId, CancellationToken cancellationToken = default)
	{
		try
		{
			var profile = await _userService.GetProfileAsync(userId, cancellationToken);
			return Ok(new { user = profile });
		}
		catch (ArgumentException ex)
		{
			return BadRequest(ex.Message);
		}
		catch (Exception)
		{
			return StatusCode(500, "Failed to retrieve profile");
		}
	}
}
