
using ExoAI.API.DTO.Logging;

namespace ExoAI.API.Service;

public interface ILogService
{
	Task<List<LogResponse>> GetLogsAsync(string userId, CancellationToken cancellationToken = default);
}
