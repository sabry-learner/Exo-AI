using ExoAI.API.DTO.Logging;
using ExoAI.API.Persistence;
using ExoAI.API.Service;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using static Google.Apis.Requests.BatchRequest;

namespace ExoAI.Api.Services;

public class LogService : ILogService
{
	private readonly ApplicationDbContext _context;
	private readonly ILogger<LogService> _logger;

	public LogService(ApplicationDbContext context, ILogger<LogService> logger)
	{
		_context = context;
		_logger = logger;
	}

	public async Task<List<LogResponse>> GetLogsAsync(string userId, CancellationToken cancellationToken = default)
	{
		if (string.IsNullOrEmpty(userId))
		{
			_logger.LogWarning("Get logs attempt with invalid userId");
			throw new ArgumentException("User ID is required");
		}

		var logs = await _context.Logs
			.Where(l => l.UserId == userId)
			.Select(l => new LogResponse
			(
				l.Id,
				l.UserId,
				l.Action,
				l.Timestamp,
				l.Details
			))
			.ToListAsync(cancellationToken);

		_logger.LogInformation("Retrieved {Count} logs for user {UserId}", logs.Count, userId);
		return logs;
	}
}