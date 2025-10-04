using ExoAI.API.DTO.Authentication;

namespace ExoAI.API.Service;


public interface IStatsService
{
	Task<StatsResponse> GetStatsAsync(string userId, CancellationToken cancellationToken = default);
}
