using ExoAI.API.DTO.Authentication;
using ExoAI.API.Persistence;
using Microsoft.EntityFrameworkCore;

namespace ExoAI.API.Service;

public class StatsService : IStatsService
{
	private readonly ApplicationDbContext _context;
	private readonly ILogger<StatsService> _logger;

	public StatsService(ApplicationDbContext context, ILogger<StatsService> logger)
	{
		_context = context;
		_logger = logger;
	}

	public async Task<StatsResponse> GetStatsAsync(string userId, CancellationToken cancellationToken = default)
	{
		if (string.IsNullOrEmpty(userId))
		{
			_logger.LogWarning("Get stats attempt with invalid userId");
			throw new ArgumentException("User ID is required");
		}

		var userExists = await _context.Users.AnyAsync(u => u.Id == userId, cancellationToken);
		if (!userExists)
		{
			_logger.LogWarning("User {UserId} not found for stats retrieval", userId);
			throw new ArgumentException("User not found");
		}

		var totalUploads = await _context.Uploads
			.CountAsync(u => u.UserId == userId, cancellationToken);

		var avgAccuracy = await _context.Models
			.Where(m => m.UserId == userId)
			.AverageAsync(m => (double?)m.Accuracy, cancellationToken) ?? 0.0;

		_logger.LogInformation("Stats retrieved for user {UserId}: {TotalUploads} uploads, {AvgAccuracy} avg accuracy", userId, totalUploads, avgAccuracy);

		return new StatsResponse(totalUploads, (decimal)avgAccuracy);
	}
}
