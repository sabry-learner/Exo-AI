using ExoAI.API.DTO.Model;
using ExoAI.API.Entities;
using ExoAI.API.Persistence;
using Microsoft.EntityFrameworkCore;
using System.Text.Json;

namespace ExoAI.API.Service;

public class ModelService : IModelService
{
	private readonly ApplicationDbContext _context;
	private readonly IFileStorageService _fileStorageService;
	private readonly ILogger<ModelService> _logger;

	public ModelService(ApplicationDbContext context, IFileStorageService fileStorageService, ILogger<ModelService> logger)
	{
		_context = context;
		_fileStorageService = fileStorageService;
		_logger = logger;
	}

	public async Task<ModelResponse> CreateModelAsync(ModelCreateRequest request, string userId, IFormFile? trainingFile, CancellationToken cancellationToken = default)
	{
		if (string.IsNullOrWhiteSpace(userId))
			throw new ArgumentException("User ID is required", nameof(userId));

		var userExists = await _context.Users.AnyAsync(u => u.Id == userId, cancellationToken);
		if (!userExists)
			throw new ArgumentException("User not found", nameof(userId));

		string? trainingFileUrl = null;
		if (trainingFile != null)
		{
			var fileName = $"{Guid.NewGuid()}_{trainingFile.FileName}";
			trainingFileUrl = await _fileStorageService.UploadFileAsync(trainingFile, fileName, userId, cancellationToken);
		}

		var model = new Model
		{
			Version = request.Version ?? throw new ArgumentNullException(nameof(request.Version)),
			Accuracy = request.Accuracy,
			TrainedOn = trainingFileUrl != null
				? JsonSerializer.Serialize(new { dataset = trainingFile!.FileName, url = trainingFileUrl })
				: request.TrainedOn,
			UpdatedAt = DateTime.UtcNow,
			UserId = userId
		};

		_context.Models.Add(model);
		_context.Logs.Add(new Log
		{
			UserId = userId,
			Action = "CreateModel",
			Timestamp = DateTime.UtcNow,
			Details = JsonSerializer.Serialize(new { modelId = model.Id, version = request.Version })
		});

		await _context.SaveChangesAsync(cancellationToken);

		_logger.LogInformation("Model {Version} created by user {UserId}, modelId: {ModelId}", request.Version, userId, model.Id);

		return new ModelResponse(
			model.Version,
			model.Accuracy,
			model.TrainedOn,
			model.UpdatedAt,
			model.UserId,
			trainingFileUrl
		);
	}


	public async Task<List<ModelResponse>> GetModelsAsync(string userId, CancellationToken cancellationToken = default)
	{
		if (string.IsNullOrEmpty(userId))
		{
			_logger.LogWarning("Get models attempt with invalid userId");
			throw new ArgumentException("User ID is required");
		}

		var modelsData = await _context.Models
			.Where(m => m.UserId == userId || m.UserId == null)
			.ToListAsync(cancellationToken);

		var models = modelsData.Select(m =>
		{
			string? url = null;

			if (!string.IsNullOrEmpty(m.TrainedOn) && m.TrainedOn.Contains("\"url\":"))
			{
				try
				{
					using var doc = JsonDocument.Parse(m.TrainedOn);
					if (doc.RootElement.TryGetProperty("url", out var urlElement))
					{
						url = urlElement.GetString();
					}
				}
				catch (JsonException ex)
				{
					_logger.LogError(ex, "Error parsing JSON for model {ModelId}", m.Id);
				}
			}

			return new ModelResponse(
				m.Version,
				m.Accuracy,
				m.TrainedOn,
				m.UpdatedAt,
				m.UserId,
				url
			);
		}).ToList();

		_logger.LogInformation("Retrieved {Count} models for user {UserId}", models.Count, userId);
		return models;
	}

}