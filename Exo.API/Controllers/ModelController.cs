using ExoAI.API.DTO.Model;
using ExoAI.API.Service;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;


namespace ExoAI.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
//[Authorize]

public class ModelController : ControllerBase
{
	private readonly IModelService _modelService;

	public ModelController(IModelService modelService)
	{
		_modelService = modelService;
	}

	[HttpPost("")]
	public async Task<IActionResult> CreateModel([FromForm] ModelCreateRequest request, IFormFile? trainingFile, [FromHeader] string userId, CancellationToken cancellationToken = default)
	{
		try
		{
			var response = await _modelService.CreateModelAsync(request, userId, trainingFile, cancellationToken);
			return Ok(response);
		}
		catch (ArgumentException ex)
		{
			return BadRequest(ex.Message);
		}
		catch (Exception)
		{
			return StatusCode(500, "Failed to create model");
		}
	}

	//[HttpGet("")]
	//public async Task<IActionResult> GetModels([FromHeader] string userId, CancellationToken cancellationToken = default)
	//{
	//	try
	//	{
	//		var models = await _modelService.GetModelsAsync(userId, cancellationToken);
	//		return Ok(models);
	//	}
	//	catch (Exception)
	//	{
	//		return StatusCode(500, "Failed to retrieve models");
	//	}
	//}
}