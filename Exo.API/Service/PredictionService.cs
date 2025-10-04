using ExoAI.API.DTO.Prediction;
using ExoAI.API.Entities;
using ExoAI.API.Persistence;
using Microsoft.EntityFrameworkCore;

namespace ExoAI.API.Service;

public class PredictionService : IPredictionService
{
	private readonly ApplicationDbContext _context;
	private readonly ILogger<PredictionService> _logger;

	public PredictionService(ApplicationDbContext context, ILogger<PredictionService> logger)
	{
		_context = context;
		_logger = logger;
	}

	public async Task<PredictionResponse> PredictAsync(int uploadId, CancellationToken cancellationToken = default)
	{
		var upload = await _context.Uploads
			.FirstOrDefaultAsync(u => u.Id == uploadId, cancellationToken);

		if (upload == null)
		{
			_logger.LogWarning("Upload {UploadId} not found for prediction", uploadId);
			throw new ArgumentException("Upload not found");
		}

		// Simulate prediction logic (replace with actual ML model inference)
		var predictions = new[]
		{
				new PredictionItem { Class = "exoplanet", Confidence = 0.85m },
				new PredictionItem { Class = "candidate", Confidence = 0.10m },
				new PredictionItem { Class = "false_positive", Confidence = 0.05m }
		};

		_context.Logs.Add(new Log
		{
			UserId = upload.UserId,
			Action = "Predict",
			Timestamp = DateTime.UtcNow,
			Details = $"{{\"uploadId\": {uploadId}, \"fileName\": \"{upload.FileName}\"}}"
		});
		
		await _context.SaveChangesAsync(cancellationToken);

		_logger.LogInformation("Prediction completed for upload {UploadId} by user {UserId}", uploadId, upload.UserId);
	
		return new PredictionResponse(predictions);
	}
}