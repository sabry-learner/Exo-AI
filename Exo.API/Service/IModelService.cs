using ExoAI.API.DTO.Model;

namespace ExoAI.API.Service;

public interface IModelService
{
	Task<ModelResponse> CreateModelAsync(ModelCreateRequest request, string userId, IFormFile? trainingFile, CancellationToken cancellationToken = default);
	Task<List<ModelResponse>> GetModelsAsync(string userId, CancellationToken cancellationToken = default);
}