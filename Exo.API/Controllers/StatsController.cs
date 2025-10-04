using ExoAI.API.Service;
using Microsoft.AspNetCore.Mvc;

namespace ExoAI.API.Controllers;

[Route("api/[controller]")]
[ApiController]
//[Authorize]
public class StatsController : ControllerBase
{
	private readonly IStatsService _statsService;

	public StatsController(IStatsService statsService)
	{
		_statsService = statsService;
	}

	[HttpGet("{userId}")]
	public async Task<IActionResult> GetStats([FromRoute] string userId, CancellationToken cancellationToken = default)
	{
		try
		{
			var stats = await _statsService.GetStatsAsync(userId, cancellationToken);
			return Ok(new { stats });
		}
		catch (ArgumentException ex)
		{
			return BadRequest(ex.Message);
		}
		catch (Exception)
		{
			return StatusCode(500, "Failed to retrieve stats");
		}
	}
}