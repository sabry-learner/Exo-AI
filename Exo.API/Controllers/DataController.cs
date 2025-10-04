using ExoAI.API.DTO.Prediction;
using ExoAI.API.DTO.Upload;
using ExoAI.API.Service;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ExoAI.API.Controllers;

[Route("api/[controller]")]
[ApiController]
//[Authorize]
public class DataController : ControllerBase
{
	private readonly IUploadService _uploadService;
	private readonly IPredictionService _predictionService;

	public DataController(IUploadService uploadService, IPredictionService predictionService)
	{
		_uploadService = uploadService;
		_predictionService = predictionService;
	}

	[HttpPost("upload")]
	public async Task<ActionResult<UploadResponse>> UploadFile([FromForm] IFormFile file, [FromHeader] string userId, CancellationToken cancellationToken = default)
	{
		if (file == null || file.Length == 0)
		{
			return BadRequest("No file provided");
		}
		try
		{
			var response = await _uploadService.UploadFileAsync(file, userId, cancellationToken);
			return Ok(response);
		}
		catch (ArgumentException ex)
		{
			return BadRequest(ex.Message);
		}
		catch (Exception)
		{
			return StatusCode(500, "Upload failed");
		}
	}

	[HttpPost("{uploadId}/predict")]
	public async Task<ActionResult<PredictionResponse>> Predict([FromRoute] int uploadId, [FromBody] PredictionRequest request, CancellationToken cancellationToken = default)
	{
		if (request.UploadId != uploadId)
		{
			return BadRequest("Upload ID mismatch");
		}
		try
		{
			var response = await _predictionService.PredictAsync(uploadId, cancellationToken);
			return Ok(response);
		}
		catch (ArgumentException ex)
		{
			return BadRequest(ex.Message);
		}
		catch (Exception)
		{
			return StatusCode(500, "Prediction failed");
		}
	}
}