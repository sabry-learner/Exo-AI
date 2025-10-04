using ExoAI.API.Service;
using Microsoft.AspNetCore.Mvc;

namespace ExoAI.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
//[Authorize]
public class LogsController : ControllerBase
{
	private readonly ILogService _logService;

	public LogsController(ILogService logService)
	{
		_logService = logService;
	}

	[HttpGet]
	public async Task<IActionResult> GetLogs([FromHeader] string userId, CancellationToken cancellationToken = default)
	{
		try
		{
			var logs = await _logService.GetLogsAsync(userId, cancellationToken);
			return Ok(logs);
		}
		catch (Exception)
		{
			return StatusCode(500, "Failed to retrieve logs");
		}
	}
}
